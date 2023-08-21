Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B357828C6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjHUMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbjHUMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:15:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249A4DB;
        Mon, 21 Aug 2023 05:15:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so17752601fa.3;
        Mon, 21 Aug 2023 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692620151; x=1693224951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w291kJh6Uu4i4etCsCc/KObNvq4GhOSiMKf8RO4JKwI=;
        b=liw57Uk0Mr3v9AE32HoCED+Z+eGisXzD1N2TWMBDG7+2J7cZASovAwzpbehu5BECoJ
         5kxctTz67o5i9WB2Q1OW3g24p2644aigARruVJ9BlfHAEeyUr8Q/534H3YquXrNoSy3e
         K0OywqMJYD6dC1J61zJlEt0QrkuZbJkaOcxQXgg0vQhFWRmGcnhdcymwtx1zZg5B39FD
         ovVT87klInKXCp2Q6qDOGGuhvlUcM7YVKZSFN8CtTWRuclX+Y79zB0lErGQld+1pt/0P
         +tcmDoDM3jiqph/FeJMiwm6acjbQgeXnrlT9VaIZuCm8Ec+jQlB/86yoZ/WaOpPEISCA
         iC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692620151; x=1693224951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w291kJh6Uu4i4etCsCc/KObNvq4GhOSiMKf8RO4JKwI=;
        b=IGgW7BKLMGB7NwrtxaqTWrXPkUAvDEzRa7eAw6K9ArrcaUE0cKh5S5+/ZTM+bzS+3C
         anTKlgssVY47z0Tq82q+1hdCyBhdOwVZDGfuXTvL3xu2lsU1GlIFQ/OmTruS/NzeGfzY
         25AjoeE2WNMkhurLd6/6hxGOx3oh6s6ons9eiKcWDvRIBnHvz4pCe2g3F5cVzLy02JJC
         ogKioR9MX8WRroHoJiT2BPDgdiFGxj18fw9X8QQWwiXTCnm1nmYKtIAxtVC8Xpt4MZtE
         HFtiwatiOLgdXsasRrdpZfifCJ29TTyCRf36eKed1yb6UW6Xaf9xAzso5z53mzSb56Zi
         sLEQ==
X-Gm-Message-State: AOJu0YyBWDzXLnA3/QUaUQebUq83aOJea+0DlYChvLN8oujFlwFtLKlf
        5B0AFhBwlamM1NhoWCIgynjVGerXcpFVIA==
X-Google-Smtp-Source: AGHT+IHkdl1866Q0i9AdsppGYbOCZ6YcrUSM97FL7UV/7xWTfPO8VGxEiDCIbt+a16mcLybwg7FGnQ==
X-Received: by 2002:a2e:9b8e:0:b0:2b4:6f0c:4760 with SMTP id z14-20020a2e9b8e000000b002b46f0c4760mr4707503lji.11.1692620151262;
        Mon, 21 Aug 2023 05:15:51 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id h16-20020a2e3a10000000b002b9ccbe074bsm2250181lja.73.2023.08.21.05.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 05:15:50 -0700 (PDT)
Date:   Mon, 21 Aug 2023 15:15:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v5 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Message-ID: <amprmav76sigvwr3vfxhb4sw4srzpld7qn3yrtue2cpxw7qsh7@qlnwdnjv4os5>
References: <20230819023132.23082-1-rohan.g.thomas@intel.com>
 <20230819023132.23082-2-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819023132.23082-2-rohan.g.thomas@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 10:31:31AM +0800, Rohan G Thomas wrote:
> Add dt-bindings for the number of tx queues with coe support. Some
> dwmac IPs support tx queues only for a few initial tx queues,
> starting from tx queue 0.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..0c6431c10cf9 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -313,6 +313,9 @@ properties:
>        snps,tx-queues-to-use:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          description: number of TX queues to be used in the driver
> +      snps,tx-queues-with-coe:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: number of TX queues that support TX checksum offloading
>        snps,tx-sched-wrr:
>          type: boolean
>          description: Weighted Round Robin
> -- 
> 2.19.0
> 
