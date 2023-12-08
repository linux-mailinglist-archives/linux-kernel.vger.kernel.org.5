Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE12480A461
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573813AbjLHNX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjLHNXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:23:55 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE869A;
        Fri,  8 Dec 2023 05:24:01 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d9daa5207eso1024691a34.0;
        Fri, 08 Dec 2023 05:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702041841; x=1702646641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFeKun/Ab01EZFKqneUQr7Yz/7P4BKP04UwHAmDFXZo=;
        b=g7OLXy2t030lvz0Vu+PFn6e5O0nXTmdCHwZscc8NnGKEzquQMPpBWkGi9B8Mg5Oh1/
         UTstChPU5rJS+/IFZbMKQT0f0rWK2TPgWzAJb0I+TSfzxTFBPHM0h7MUBmbCOY6ahMT/
         jKXSkZGJaQqLdb/DsKia9O710NjoNvErOcPNymMXpSeTYSajVPy5f/QWMGlEGaNduvx1
         6ul7AzBq4je6UWy4vxVZyTPfJQqVX/mZZ8uPmIEOVf9+hcvFQuZvgUHUUWTNmzMoi/nU
         flEIibMx6P4LV39lvvpTRN1D7I21i5RFGUSssddr34vMylhOg7+LeOEVtvc6m+eHVBeW
         9DaA==
X-Gm-Message-State: AOJu0YyOtlrMll/iZ9R/Nzg9oeFj73uB+NC9kORGamO/peknIGZcXV+T
        R1lW6t0zx5+7hj8qfIfC+Myj9ny5FA==
X-Google-Smtp-Source: AGHT+IEwvAkq9jK6mGhGY5c1svm3c0hRJ957nkwsNCjpz2Tmg7njhNnkY9qrkTB/OkIZBtm29yuCYQ==
X-Received: by 2002:a05:6830:1159:b0:6d6:441a:a6c with SMTP id x25-20020a056830115900b006d6441a0a6cmr21946otq.12.1702041841089;
        Fri, 08 Dec 2023 05:24:01 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w26-20020a056830061a00b006ce28044207sm297875oti.58.2023.12.08.05.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:24:00 -0800 (PST)
Received: (nullmailer pid 1155913 invoked by uid 1000);
        Fri, 08 Dec 2023 13:23:59 -0000
Date:   Fri, 8 Dec 2023 07:23:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] dt-bindings: cache: qcom,llcc: correct QDU1000 reg
 entries
Message-ID: <170204182670.1155646.3136881067040734815.robh@kernel.org>
References: <20231107080436.16747-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107080436.16747-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Nov 2023 09:04:36 +0100, Krzysztof Kozlowski wrote:
> Qualcomm QDU1000 DTSI comes with one LLCC0 base address as pointed by
> dtbs_check:
> 
>   qdu1000-idp.dtb: system-cache-controller@19200000: reg-names:2: 'llcc2_base' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Recent LLCC patches were not tested on QDU1000 thus the LLCC is there
> broken.  This patch at least tries to bring some sense according to
> DTSI, but I have no clue what is here correct: driver, DTS or bindings.
> ---
>  Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

