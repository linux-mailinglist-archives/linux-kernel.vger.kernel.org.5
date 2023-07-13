Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A8751F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjGMLGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjGMLGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:06:33 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C782738
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:06:21 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ca3cc52ee62so523898276.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246380; x=1691838380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WiV/7q29Lz9ovivX2FWAx1Ldp08v14j+trL88mxoLRY=;
        b=eHuodEMDmc0gaOLGxz4ZOl2QDUjscsSR534Yb0lsjWkR+iDaGKmcW504dn05tzvAjx
         1yz4d5P/2M+6vgpGuNhuApckUlcmKYeE3f1/lU1wNBBnn58JW5MniNKq5Z/dRKuYaEgR
         MA5xl2XLjoVlTuurE4+ycjzM5DO6556A+sVkde3usYGkl+JnZwJYRsHzxbI1NoG+pgd0
         a3KeCvwvYTkQoOzQAc5KAe7VvTb7jqrEaxPixzse8rw3QIl2IVD+oi4gqdVV5ihaHu4p
         wTfflQTZZd4gb/zcdeUUWlkA6KrsMxQ4FJOWZIknrqw79Xe16SUChZkpfheZoAS7wiib
         jvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246380; x=1691838380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiV/7q29Lz9ovivX2FWAx1Ldp08v14j+trL88mxoLRY=;
        b=WB2Jy9fI8uaoHV0R1TPv04jkIs3AOwhkyBccRJ8nNEtpJzqVHEuLoWXwxxLFPtysM/
         l3qfofPG9+PO2YsgPcx5gy1YAq5KlizU2ovnbZ6Sy7omLprhqSXmQJzwZa8kyUqFNI6A
         LV/MQ7oBCifDAgEloSBPQE3iSRn+ZK8rHffOWPjfpwbJIS+M+3BWu0H/2HuSGy0Na9V2
         yAuNcly/VMKV3Zh7xZGQhH1M+aghECKsv52mFBCNUOaN19PROICegEhWlA9Fk3nAGm/I
         e2wi78QSu1Mh7hCmYh1+SXOGhlytT8/FxSKrssU4eUv3GK6wrzXZJOzpeewDcQjMo7wE
         3/Aw==
X-Gm-Message-State: ABy/qLYGpHgWyPx75nKId+GM/r2FbB/ycs2Jp9tqyFph1fDldacUqRPl
        MtfQjGL+cWVslNkWXCCNOFPVAwDvNu8BvsyE/IuUXQ==
X-Google-Smtp-Source: APBJJlGvdFT1I5LlLlSZ1vXvHoB35pTHYRo+rkqezmhzn+Qzriqe/07gvMGjawbihGymi4kllx31OgEP5eBDfTAEQME=
X-Received: by 2002:a25:8550:0:b0:ca7:aad7:3091 with SMTP id
 f16-20020a258550000000b00ca7aad73091mr918328ybn.27.1689246380252; Thu, 13 Jul
 2023 04:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184318.551317-1-linux@fw-web.de> <20230629184318.551317-2-linux@fw-web.de>
In-Reply-To: <20230629184318.551317-2-linux@fw-web.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:05:44 +0200
Message-ID: <CAPDyKFrvQWUQuT_SX=hArY9TP61naN0gzaZ+8qo6PnOMntn9gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: drop assigned-clocks/clock-parents
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 20:43, Frank Wunderlich <linux@fw-web.de> wrote:
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> MT7986 has 2 clock-parents and these properties are not needed in driver
> binding. So drop them completely.
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2:
> - drop assigned-clock* completely based on discussion with Krzysztof in v1
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 46eefdd19a2c..3fffa467e4e1 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -91,16 +91,6 @@ properties:
>        should switch dat1 pin to GPIO mode.
>      maxItems: 1
>
> -  assigned-clocks:
> -    description:
> -      PLL of the source clock.
> -    maxItems: 1
> -
> -  assigned-clock-parents:
> -    description:
> -      parent of source clock, used for HS400 mode to get 400Mhz source clock.
> -    maxItems: 1
> -
>    hs400-ds-delay:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> --
> 2.34.1
>
