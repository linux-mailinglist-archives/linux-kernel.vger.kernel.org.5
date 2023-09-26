Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254D37AEA9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjIZKly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjIZKlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:41:53 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBDB101
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:41:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-578a3069f1eso5465060a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695724906; x=1696329706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lSWJC//rMZdfMKBsyCVpinhHKBaaOO78CmTA3WsbQBU=;
        b=WI+g2pfo8ahqvhVyISn9tV2CgwUA0myNyOqucA4Xluxz8ytjhSivH+YqbjcNRgbrcn
         CNkH0v7QCtsITIxbjnaaSJuNuNtJAOU/+vysl7kX9txggtD14Lh4tk3hiPngZvhNDgBf
         F9ZmPWtqqwo7qRWMgi0yWUNYsn/Q7GgI9ylwAiDE+Vt14kCMV4YcuorgpGQDjFtd/27T
         zPZfFZ1RUTvMTDkqaz77n/Y1Ern+NPXSsejRUnx8hJIwjL8yvzdENJ1xXLKFIvJnfaUC
         nnEWRXiGjejLLzjZ/6elv5Ds6HHRUApTVx6pzPvyDNxRTKRStYVBa0pn2eZL/kQA2BRn
         BdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695724906; x=1696329706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSWJC//rMZdfMKBsyCVpinhHKBaaOO78CmTA3WsbQBU=;
        b=ETvyj0rSWeiYqCAgn9ae3iSSmQm2GxyKBLZB55vzgMH6EyCmRE0tpx1V00yyOhnCHX
         8I0sAd+hxoUUeRihVPLIWTADicBzs2h5OWBHcH0bKhAn8TVVjjjaWQYlmqBILVbOtJlu
         bth7v9rj2jJctZ1UXaidJic5JmvxLM0QcTEEr2H8ylgoeRA5x37vR9HD96hOmErOMMeN
         8DhXSpc+DCS0aOKsmvj/H5IDgxie/X3uIU0Yj/yWNo8yzS1XDdYaeV3B+b63PsXGWvt6
         oT24Rd/g5bepbhsyH3nfnFK2KB0MOlYulBP16ejIXGvk7MHen55tJWp5b9hdm4WJ5Mxd
         9e/Q==
X-Gm-Message-State: AOJu0YxJ9hozH82NGwzutsCZUH9QNCIAYLD73v1C161u1rTbZ0kBR3g4
        o5yfgv7bGwb3ZWE61+VC+MsklMC8a41A7fIO3m9NmA==
X-Google-Smtp-Source: AGHT+IEABlvjgUiC/l2noFGyiy4QIJmw3FGGuAmOCafGHPrLpz1AuVmuQMCO92cIIizonKPuAukE5QxkYH2JLwrNPNQ=
X-Received: by 2002:a17:90a:728e:b0:274:6503:26d with SMTP id
 e14-20020a17090a728e00b002746503026dmr6479095pjg.33.1695724906247; Tue, 26
 Sep 2023 03:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230925220511.2026514-1-robh@kernel.org>
In-Reply-To: <20230925220511.2026514-1-robh@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 26 Sep 2023 11:41:35 +0100
Message-ID: <CAJ9a7Vji+0vqSPBq2Kr14wZ5mXFCqi7f+L79i3VmE=rg9UGchw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm,coresight-cti: Drop type for 'cpu' property
To:     Rob Herring <robh@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sept 2023 at 23:05, Rob Herring <robh@kernel.org> wrote:
>
> 'cpu' has been added as a single phandle type to dtschema, so drop the
> type here.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> index 6216cfb0a188..b9bdfc8969cd 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> @@ -92,7 +92,6 @@ properties:
>      maxItems: 1
>
>    cpu:
> -    $ref: /schemas/types.yaml#/definitions/phandle
>      description:
>        Handle to cpu this device is associated with. This must appear in the
>        base cti node if compatible string arm,coresight-cti-v8-arch is used,
> --
> 2.40.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
