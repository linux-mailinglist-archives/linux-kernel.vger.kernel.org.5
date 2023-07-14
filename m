Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6FE7543E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbjGNUmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGNUmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:42:19 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB9110EA;
        Fri, 14 Jul 2023 13:42:18 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-78372b895d6so96566839f.2;
        Fri, 14 Jul 2023 13:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689367338; x=1691959338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LbqJ6zXOPDGWOilPHjFLOaklHdhEx1BFjvpxBlFtPk=;
        b=BP7A1gfvirsdJL99ubyrHvrHwOhzgQtHeXwp8ljc2N2Dm/KIWMemf/YfCcJ39YBRE7
         WuRqgzW7TQWNRIFKWYVXQdOkT/k2LWdtton+pRdGyaEBAvI6bS7do78jPwxtOqZTSHm0
         n4sJT/a4qjyClW2tTYLEXyjyjDfkiZ5fdYt2MipRIheCT3CVjr++eAUpp1ukLZ/4rWlh
         le9jYUbdXqF6BbN7Vn8KLugsePCGx+V57aZgsT4FURQzePt+DwO59RZSa7J4kB17h2Rr
         MDp1VLpG7VMTgWNX7/UlS3wh+cCOoOgPqdcZU7MbgCgcCJAKtIkmYToNi0FgjqC+LD16
         Hg4Q==
X-Gm-Message-State: ABy/qLb9POj7Zttre7SA2Utn0X6RtTgYpc+sQJo6joUajFlAMt0yRL0I
        SIJBoY2rjG6QKCejldYOsg==
X-Google-Smtp-Source: APBJJlGHg9/0YrI+Hc61WkaHX7Ct+ZzGpamnPGrOh3ePm5ep6ii2lpupMZM2d07Y7BOfFGm1O5ftZQ==
X-Received: by 2002:a5e:c918:0:b0:786:f10e:a473 with SMTP id z24-20020a5ec918000000b00786f10ea473mr7029664iol.16.1689367337821;
        Fri, 14 Jul 2023 13:42:17 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l22-20020a02a896000000b0041cd626ea0csm2841728jam.147.2023.07.14.13.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 13:42:16 -0700 (PDT)
Received: (nullmailer pid 184877 invoked by uid 1000);
        Fri, 14 Jul 2023 20:42:03 -0000
Date:   Fri, 14 Jul 2023 14:42:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anusha Rao <quic_anusha@quicinc.com>
Cc:     andersson@kernel.org, davem@davemloft.net, conor+dt@kernel.org,
        herbert@gondor.apana.org.au, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, bhupesh.sharma@linaro.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-crypto@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        quic_saahtoma@quicinc.com, thara.gopinath@gmail.com
Subject: Re: [PATCH V4] dt-bindings: crypto: qcom-qce: add SoC compatible
 string for ipq9574
Message-ID: <168936732126.184802.4976724708765601925.robh@kernel.org>
References: <20230714093032.22400-1-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714093032.22400-1-quic_anusha@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jul 2023 15:00:32 +0530, Anusha Rao wrote:
> Document the compatible string for ipq9574.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
> NOTE: This change was added as part of the series below
> https://lore.kernel.org/linux-arm-msm/20230526161129.1454-1-quic_anusha@quicinc.com/
> Since the dts change is picked, this patch is required
> to resolve CHECK_DTBS issue
> 
>  Changes in V4:
>         - Updated subject prefix to include subsystem crypto.
>         - Picked up Acked-by tag.
>         - Picked up Reviewed-by tag.
> 
>  Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

