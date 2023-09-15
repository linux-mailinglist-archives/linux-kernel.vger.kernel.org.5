Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55857A1B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjIOJ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjIOJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:57:57 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2895F420C;
        Fri, 15 Sep 2023 02:56:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b962c226ceso30500501fa.3;
        Fri, 15 Sep 2023 02:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771790; x=1695376590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZHXidyPhieegEzovxd1gt+iM+Tc1BYrb9548qsMDG4=;
        b=YaS8k7p3ZhM9Uy966Vr0qTHOH2Y75oNnFvezWXWBfIayfrB/fkIsEsW19lYNv6E4Mm
         G0GndHidJ0w0b5fSDEyu6eKVYG/6NNGqPDN5+OnfHJ/gmZbQcnXT1X1QinpCZ2uqTVhr
         H4pBndrdAChauO/NmzUIWgHEH7LTVj1CbNeYV9uj+ctb+vsO2c9IeqdXqNFKnhJxnz/b
         wpPUBfPl0QVgJCfusnQLJvnISirkPaJCMIxGXktHt91BKUTyofkkoQqOrIzkZpA2PlIO
         /CbQomVQuanheRPr5PkMajo/YllQRYctqmxDmlg5jC4mySsKWqrsnVFf4Z06M465pm2V
         OKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771790; x=1695376590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZHXidyPhieegEzovxd1gt+iM+Tc1BYrb9548qsMDG4=;
        b=Z7jmgCRCcIQrVIY6HYh4KltcPXe8lgmFxddSfNd0tM2cqUvbnR9eBIGThsV+vHzNwb
         3ddtRg9Y+14Du2oBiQybFbieL62DZPwNXwJIJprZTMc7yHzbMd0XjC4LJz69BJHpiZOu
         YefZWzwPf+t7NLs5SBoovG41qISg1H7DGRKbDMYVbp+Eh1MdOBAUGxuQbvBQBA25aVpF
         jA56yL52An0Xq7jSSj/hOZEBtb1tm5ofMrfscgluyU2yZa89LoA0fLCuQhXrXVWBgH2r
         olqU1LmAYjVpzed4nFAPNPMzzwC9LkCMTspwPeLl9ee1RylMbz5tAEWNc4TryNb6Lzju
         DAtg==
X-Gm-Message-State: AOJu0YwGcJkSFv07Dfi/3UFILCSPWaGcK38Y5zChRAGn++XtUiDTQV1i
        JLFoIzV2XU8lzrKeXlGHIXs=
X-Google-Smtp-Source: AGHT+IHOgt5elso1qZVUlfdKLdET/gYXYQaSCicao69AuSEzGiiTJCnL9vg7Rc/2OQEGPrxaFcDyHw==
X-Received: by 2002:a2e:97d0:0:b0:2bc:b27f:4019 with SMTP id m16-20020a2e97d0000000b002bcb27f4019mr1204321ljj.6.1694771789626;
        Fri, 15 Sep 2023 02:56:29 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y21-20020a05651c021500b002b6daa3fa2csm643460ljn.69.2023.09.15.02.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:56:29 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:56:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: mfd: syscon: Add compatibles for
 Loongson-1 syscon
Message-ID: <toesc3jzvlterrxhfdusnyt2mku7zbkk5yapvtwddmxm6leczh@dpsm2uf52obj>
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
 <20230914114435.481900-2-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914114435.481900-2-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 07:44:33PM +0800, Keguang Zhang wrote:
> Add Loongson LS1B and LS1C compatibles for system controller.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
> V4 -> V5: None
> V3 -> V4: Add Acked-by tag from Krzysztof Kozlowski
> V2 -> V3: Change compatibles back to loongson,ls1b-syscon
>           and loongson,ls1c-syscon
> V1 -> V2: Make the syscon compatibles more specific
> 
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 8103154bbb52..c77d7b155a4c 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -49,6 +49,8 @@ properties:
>                - hisilicon,peri-subctrl
>                - hpe,gxp-sysreg
>                - intel,lgm-syscon
> +              - loongson,ls1b-syscon
> +              - loongson,ls1c-syscon
>                - marvell,armada-3700-usb2-host-misc
>                - mediatek,mt8135-pctl-a-syscfg
>                - mediatek,mt8135-pctl-b-syscfg
> -- 
> 2.39.2
> 
> 
