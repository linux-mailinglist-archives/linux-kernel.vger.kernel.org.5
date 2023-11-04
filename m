Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355EA7E0CCE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjKDAmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjKDAmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:42:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E27D65;
        Fri,  3 Nov 2023 17:42:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc30bf9e22so21541325ad.1;
        Fri, 03 Nov 2023 17:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699058565; x=1699663365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3Y+2xaHnflYFGEjW6RHSfv3vt/a3BkZ1RQyBsRDATU=;
        b=B4RKA+EpttQG4xCkqP25ngIUuf9Koxpkhe9qvc3bBpXW/bMKq724NBlR8O1V9JFMyk
         fh53UrB4+6VuyjBv+k5oWEi4XzzrJaqfCINFXbbx59fuFhYAIk18y+H09HwPwlKKBWPc
         cFMUFTHxqw3QfKWmGfbXu4VGWSISXB5YNR+ocXBqPrYSs2oTHw42LXqHjPP8KAAy+qji
         ElmFbufIDsDOXhzqir+7JXZ+2rCzKKBBIcAxpeSylrHqeMQYy9O8eT8GAKUw+94QpZJ3
         QYU1EuiZY6WVQ/8M40BSdjCQz1tQ3bkoEobV+ff+/PZ6Lz/mF/Hx38vpnKP1FHTuDi7H
         2SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699058565; x=1699663365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3Y+2xaHnflYFGEjW6RHSfv3vt/a3BkZ1RQyBsRDATU=;
        b=XDPZmTauPIzys1kWp6RnGaAErRvMlXHHg4CxlexnbXGgrzsZRkNPACIDj4IuO8Jl8k
         +cktpaeYP7QpmAiCStwlgf1K28mBX7e7j6I5s1X7oqsruBiKKc8BD3iqIKYVenW45pB2
         EHYeYrGOm/q8osdka7wEydLMc5RQnb0sYGUxPcBKzJaQsY0yU3nzWsnb3cW10AbZmrKe
         FWVZzpGZvNQkE+XT+p3mp+vgqZPxE3jEv56ByyzIExv1SPU6os79gylAVT7j1qc/EGuY
         1cbfCADSeTn6235nkJ4Lt1CkEG8GoTib07Ex4OjOy0VA3tZZciPa52eYKj78Nk9MHn5m
         3PzQ==
X-Gm-Message-State: AOJu0Yxeqqc0jMFLUjUIRHQRuas4tCbE28UH47bKit9iuRYlY2qdHDZB
        BAgG6s4p/HvLYR5MAAFxuJs=
X-Google-Smtp-Source: AGHT+IE170PtEf3phUWelsLkk6l+PKqyZN+X8i9TQ4nEADbJ6lRJtwkTQyx6fQc2EZzZUK+/tFoO2w==
X-Received: by 2002:a17:902:cf46:b0:1cc:33e7:95f5 with SMTP id e6-20020a170902cf4600b001cc33e795f5mr4302698plg.33.1699058564715;
        Fri, 03 Nov 2023 17:42:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001cc40912649sm1899964plb.304.2023.11.03.17.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 17:42:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 3 Nov 2023 17:42:43 -0700
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
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] arm64: dts: qcom: sm8150: Make watchdog bark
 interrupt edge triggered
Message-ID: <39fb1431-50c7-4c05-b439-6d82e71a7ff8@roeck-us.net>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231103163434.4.I23d0aa6c8f1fec5c26ad9b3c610df6f4c5392850@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103163434.4.I23d0aa6c8f1fec5c26ad9b3c610df6f4c5392850@changeid>
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

On Fri, Nov 03, 2023 at 04:34:30PM -0700, Douglas Anderson wrote:
> As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> interrupt should be configured as edge triggered. Make the change.
> 
> Fixes: b094c8f8dd2a ("arm64: dts: qcom: sm8150: Add watchdog bark interrupt")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 97623af13464..ad4fab61222b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -4170,7 +4170,7 @@ watchdog@17c10000 {
>  			compatible = "qcom,apss-wdt-sm8150", "qcom,kpss-wdt";
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
