Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3BF753FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjGNQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbjGNQRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:17:42 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716802707;
        Fri, 14 Jul 2023 09:17:37 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3456fda4ed1so9958005ab.0;
        Fri, 14 Jul 2023 09:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351456; x=1691943456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDVAiCPgiCLUr/CSIMms8dz09Iz8VdUpjeBHbhE5dU0=;
        b=ORKVKaveEiTnGf+EaiAtLkYTNz8Uish/FIhkyxP19Ic7ByVCgQGw0lx2Jft4R9jVdj
         hQwyhK35c6eL2Wez4JwrAM2Nld1MayW419Jg71MWFDtdVdGFAtg+zR/oFeLcdE4JJA4Q
         JOu3NY8iRj5QgZCfcH7wZ7zGGGEZgeuDOaBUu65oTxJJHsgrLEc1kSvDuONBm4OmMrUN
         DlUok6KkvCCanWloH29rVvh5LoT7TUO7ec+W9pZ6sKj5+FDoCSVncdhtR/YB4OgGQL8J
         ugIk7eN5WVzzFFJFdOSaSbyzbW7Bc2uVKvNJblpbjRH+TLKkIKUNMbRq/x1VyU0xoTp5
         W8uQ==
X-Gm-Message-State: ABy/qLbN4W6k3rkM0LSChlDs2Q3l9yjZiPSxIxix7O3QXGeHiQRZUi5h
        8OTcTy/n8khNmpzo+K0Ymg==
X-Google-Smtp-Source: APBJJlFY30LAu76EUJ9UBwm5e7258g1w+cX0Llt2LbQKg3PSkbN2a6y7yEPRihySrAFfWGw0WRTWwA==
X-Received: by 2002:a92:d9cc:0:b0:346:1185:31d0 with SMTP id n12-20020a92d9cc000000b00346118531d0mr4693547ilq.9.1689351456663;
        Fri, 14 Jul 2023 09:17:36 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g11-20020a0566380bcb00b0042b48e5da4bsm2592963jad.134.2023.07.14.09.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 09:17:35 -0700 (PDT)
Received: (nullmailer pid 3942584 invoked by uid 1000);
        Fri, 14 Jul 2023 16:17:33 -0000
Date:   Fri, 14 Jul 2023 10:17:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_asutoshd@quicinc.com,
        quic_cang@quicinc.com, quic_nitirawa@quicinc.com,
        quic_narepall@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_richardp@quicinc.com, quic_nguyenb@quicinc.com,
        quic_ziqichen@quicinc.com, bmasney@redhat.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 02/14] dt-bindings: opp: Increase maxItems for opp-hz
 property
Message-ID: <20230714161733.GA3938393-robh@kernel.org>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712103213.101770-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:01:57PM +0530, Manivannan Sadhasivam wrote:
> Current limit of 16 will be exhausted by platforms specifying the frequency
> for 9 clocks using opp-hz, like Qcom SDM845 SoC: 9 * 2 (64 bits) = 18

Are you sure about that? opp-hz is defined as uint64-matrix, so 16 
64-bit entries should already be allowed. It doesn't matter how the .dts 
is encoded (it used to though).

> 
> So let's increase the limit to 32 which should be enough for most platforms
> (hopefully).
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> index 47e6f36b7637..e2f8f7af3cf4 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> @@ -56,7 +56,7 @@ patternProperties:
>            need to be configured and that is left for the implementation
>            specific binding.
>          minItems: 1
> -        maxItems: 16
> +        maxItems: 32
>          items:
>            maxItems: 1
>  
> -- 
> 2.25.1
> 
