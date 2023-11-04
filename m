Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582937E0CC7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjKDAma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjKDAm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:42:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE569D50;
        Fri,  3 Nov 2023 17:42:25 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso1611895a12.0;
        Fri, 03 Nov 2023 17:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699058545; x=1699663345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNJs6XPdcEffdKekDZQ8t6nZVate0ybj5d5gDZViJeM=;
        b=TdF8inZmYb2Lt+vTBA/8M7CwFa6je9hOxkSAOrWZx8FqaTkJclmLU9WaEqd7T3ko9F
         ptMYreWLdwggke0D+FXqj7vB1TOUUpDRaC7654lAcUtfKd0vatwqwW6x7dwbC/TP3fMf
         Gzd67TvQUE6lL3Tcs6Hu0hcdrEB9VU0VdTjW/AHsryDVndYkRxbf4pkSMtHxdKRVdQhv
         DBUuCplM9DnE1Pskhu4UhjNWHaBF2V/8plSnZ2U6C6s5HrqDKJG2D+3sIzwfno4wxh7X
         wTWOOgnWTZT32gwaDtk7wb2DYj+IljZnec3VdA1UeKTYeZxWiBMn25Qa+E4hlnMXSak+
         rqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699058545; x=1699663345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNJs6XPdcEffdKekDZQ8t6nZVate0ybj5d5gDZViJeM=;
        b=A/Yk9zxKh9xlFqv4WLRT+3OJwZHXrqyFY8aGj0XvuNh2kks2O6vTaAoi9rORADzW31
         sxmnEE9mzqdPhbjK9SlyLhJ3EBIhbhYisC1Gk71aRhWXTakCU9HUmPfq4MiAts0D+qr+
         h54Atcmxc7AmwAu4HCnJXYSKPc2FuUMujdX2/bsZMoQptLKN95RK6efGwXM55mXsBsrt
         kYd+XeFy9WnDXFitw/i95LqdNGLaKwE4lNRy5cSyY/C/P9DDEaFFfjzEfe0k0Gk9op0F
         eR6+y8nBmWG06YHU5hA1D9iesken8x6It05IQTDTrK2T9zJur2w1GDHcpnE8SVfcBeK6
         b4hA==
X-Gm-Message-State: AOJu0Yz1IlB79jS9swCcoJhOFp+h0GBF3U1EGpVIngC+jwmPRfCq3Ffl
        ofIeXVTrDnJa6Lyrdumey3U7+XkUsjU=
X-Google-Smtp-Source: AGHT+IEeatN/+OWh21pmYXKP9imKxLtNej5UDKs9xnM54MMyQi7mkJE7gDlMfkkxNVSpuGprdg7R/w==
X-Received: by 2002:a05:6a21:3e0d:b0:181:671f:446c with SMTP id bk13-20020a056a213e0d00b00181671f446cmr9764270pzc.58.1699058545283;
        Fri, 03 Nov 2023 17:42:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b00263f41a655esm2027874pjf.43.2023.11.03.17.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 17:42:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 3 Nov 2023 17:42:24 -0700
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
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] arm64: dts: qcom: sc7280: Make watchdog bark
 interrupt edge triggered
Message-ID: <80703bc3-20f4-43dc-9241-80910408a1c4@roeck-us.net>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231103163434.2.I11f77956d2492c88aca0ef5462123f225caf4fb4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103163434.2.I11f77956d2492c88aca0ef5462123f225caf4fb4@changeid>
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

On Fri, Nov 03, 2023 at 04:34:28PM -0700, Douglas Anderson wrote:
> As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> interrupt should be configured as edge triggered. Make the change.
> 
> Fixes: 0e51f883daa9 ("arm64: dts: qcom: sc7280: Add APSS watchdog node")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 04bf85b0399a..1964ef66492f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -5389,7 +5389,7 @@ watchdog: watchdog@17c10000 {
>  			compatible = "qcom,apss-wdt-sc7280", "qcom,kpss-wdt";
>  			reg = <0 0x17c10000 0 0x1000>;
>  			clocks = <&sleep_clk>;
> -			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
>  			status = "reserved"; /* Owned by Gunyah hyp */
>  		};
>  
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
