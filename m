Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD427A5623
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjIRXRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIRXRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:17:43 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42690;
        Mon, 18 Sep 2023 16:17:37 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-65806ba1221so7290056d6.1;
        Mon, 18 Sep 2023 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695079057; x=1695683857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZgj0kNITFKrAtHYiEcQ7nJa+lwRZCA5FwjQ7D2PR9k=;
        b=Dp6L49XhV+cbUVBE63uISyG5eKSfsY+AkTHOnK4aVTRilINfvaWP7Ct74AmdysaKn8
         CzG/IVGBSVU0/+xyiF2NIpE7S7/jsImN59hSvbc/0u+CmNQZXeDCSXzuZ7Miwn1tLSRN
         KZrWhYQIax4wv7/tkgxax0HqvwpX5zk/tELpVWIwtGqx1vAbzLL0WQ9Wf/9vyXR2waCU
         2nmHdsPyRIFsw9TBqlJ6Z7UcGITnrHmQ3bIeFgv3TCxlEzCSAYm6GgnmEhXYH6T/vxbY
         lQMbZWieLuWNkwLXxJHydVAdHDIi3BByk3JQa4nxLR3CsWUtr1OXJdSsFv00O8f290Yo
         IMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695079057; x=1695683857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZgj0kNITFKrAtHYiEcQ7nJa+lwRZCA5FwjQ7D2PR9k=;
        b=YGzlq2IHsliWK2qyNN295ChbYqn6kO9Kb9V/p9uLpDubZ0QF8PwKT5wE9bIAn06utb
         ryHyU4iDC4DZaR0CCdUE6khWg69vzCZNuC77MYZn7K9PeLVUX/ErlBDrzkwu9EHUU2pk
         XelxyJNC9p0YxH2G/F4YCK8B2cciwHwC13BQepbTTpla+EwqviSKplMTfPOTev3Iio5B
         tds//4QHan0D4cBW2EU3Enbd7FDmh1RxhjsmtPaXY7KyVf/UwIE6MprU9fdVSvhi56dE
         0oynhe3eoBLLebDG7weFLKt7Ywp8w7kTU7yseJv/Euhp1N0creVwT1uj2j5PcTCeMmmi
         PGkg==
X-Gm-Message-State: AOJu0YwJfiArthJBLS+xyJ31nn4guHzPWLkPAdD1Avpkq4FqQNVA8Y5P
        Gln7UPuaWZ7A4Ktb2j5LNh0AshVOkM8=
X-Google-Smtp-Source: AGHT+IHV7oqbfK6jGt4sVAIS6wPFmLSqCrwrnE3qUAQyHr2zntSI1doa5jU5ZdoXVj/x/F2Rv5uZKQ==
X-Received: by 2002:a0c:b2ce:0:b0:649:8baa:2986 with SMTP id d14-20020a0cb2ce000000b006498baa2986mr10283553qvf.2.1695079056742;
        Mon, 18 Sep 2023 16:17:36 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::ef5a])
        by smtp.gmail.com with ESMTPSA id i13-20020a0cf38d000000b0064f5d70d072sm1145542qvk.37.2023.09.18.16.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 16:17:36 -0700 (PDT)
Date:   Mon, 18 Sep 2023 19:17:34 -0400
From:   Richard Acayan <mailingradian@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm670: Fix pdc mapping
Message-ID: <ZQjajpc4VLslnGgv@radian>
References: <20230818-topic-670_pdc_fix-v1-1-1ba025041de7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818-topic-670_pdc_fix-v1-1-1ba025041de7@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 01:19:09PM +0200, Konrad Dybcio wrote:
> As pointed out by Richard, I missed a non-continuity in one of the ranges.
> Fix it.
>
> Reported-by: Richard Acayan <mailingradian@gmail.com>
> Fixes: b51ee205dc4f ("arm64: dts: qcom: sdm670: Add PDC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Just a friendly reminder to everyone that this patch is still here.

Also, I see no issues arising from this patch.

Acked-by: Richard Acayan <mailingradian@gmail.com>

>  arch/arm64/boot/dts/qcom/sdm670.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> index 84cd2e39266f..ba2043d67370 100644
> --- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> @@ -1328,7 +1328,8 @@ pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sdm670-pdc", "qcom,pdc";
>  			reg = <0 0x0b220000 0 0x30000>;
>  			qcom,pdc-ranges = <0 480 40>, <41 521 7>, <49 529 4>,
> -					  <54 534 24>, <79 559 30>, <115 630 7>;
> +					  <54 534 24>, <79 559 15>, <94 609 15>,
> +					  <115 630 7>;
>  			#interrupt-cells = <2>;
>  			interrupt-parent = <&intc>;
>  			interrupt-controller;
>
> ---
> base-commit: 7271b2a530428b879443b274c191b34536a4ea11
> change-id: 20230818-topic-670_pdc_fix-d07fbdf4d179
>
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
>
