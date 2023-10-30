Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28E7DC052
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjJ3TWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjJ3TWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:22:38 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F2DA9;
        Mon, 30 Oct 2023 12:22:36 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1dceb2b8823so2403839fac.1;
        Mon, 30 Oct 2023 12:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693755; x=1699298555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1Fy0CpFtgcJshYzVPax3hE6Wvgw3zG9+HWgIo8OoEY=;
        b=ZZYSJFHQ48WcF2GHpVFqvMh699OouiY6MwqFESEmnqu//nG9tKPfl61pqAzkoS4y5t
         i+lPKqAsc41j13biMiTV8NQxeiqZ25rUAxZnh6w9J8G8VZWYtc532F+hjl72hbCs8inJ
         egg+YqBF5Bm4Oys1urJ8MnzGyW1AgfB4a+zi0KShCbqhHBvqup2S+TH1ahTuuwNfHPU+
         fMnOaxIDnM7Am4NnhLIGGySX6+1Gecg3tWLfuT6SJQMF1ikNEc0cFlHfs6T2QB7Y2xec
         E8Hej1bpAxIZ3JvtXSQhpCrml82mrosIsoPU182bi1TYqbOpiZ9OjaC3lD0t+TSPSfVX
         aBgA==
X-Gm-Message-State: AOJu0Yxym9YbkNnxwM6a/ZqaHZYxbOFaymoZFVMyHzAo9LCzaIBu9ndw
        KdiLw46DZhs/+LZMU7TCDg==
X-Google-Smtp-Source: AGHT+IFqCpZAhcTsmCaH5gXcwYyQqwa/kJtNlFwsxXctOhLFSYJq+4Kpo0+H1/CaGdSxDzUCwVUNkA==
X-Received: by 2002:a05:6870:a18:b0:1e9:f0c5:4496 with SMTP id bf24-20020a0568700a1800b001e9f0c54496mr301891oac.1.1698693755333;
        Mon, 30 Oct 2023 12:22:35 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6c7:c3eb:a6fd:69b4:aba3:6929])
        by smtp.gmail.com with ESMTPSA id w1-20020a056870854100b001e1076a668asm1695993oaj.36.2023.10.30.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:22:34 -0700 (PDT)
Received: (nullmailer pid 1962342 invoked by uid 1000);
        Mon, 30 Oct 2023 19:22:32 -0000
Date:   Mon, 30 Oct 2023 14:22:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 02/16] dt-bindings: media: mediatek: mdp3: merge the
 indentical RDMA under display
Message-ID: <20231030192232.GA1922580-robh@kernel.org>
References: <20231030100022.9262-1-moudy.ho@mediatek.com>
 <20231030100022.9262-3-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030100022.9262-3-moudy.ho@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 06:00:08PM +0800, Moudy Ho wrote:
> To simplify maintenance and avoid branches, the identical component
> should be merged and placed in the path belonging to the MDP
> (from display/* to media/*).
> 
> In addition, currently only MDP utilizes RDMA through CMDQ, and the
> necessary properties for "mediatek,gce-events", and "mboxes" have been
> set up for this purpose.
> Within DISP, it directly receives component interrupt signals.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,mdp-rdma.yaml   | 88 -------------------
>  .../bindings/media/mediatek,mdp3-rdma.yaml    | 55 +++++++++---
>  2 files changed, 45 insertions(+), 98 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml


> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> index 3e128733ef53..c043204cf210 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> @@ -20,8 +20,9 @@ description: |
>  
>  properties:
>    compatible:
> -    items:
> -      - const: mediatek,mt8183-mdp3-rdma
> +    enum:
> +      - mediatek,mt8183-mdp3-rdma
> +      - mediatek,mt8195-vdo1-rdma
>  
>    reg:
>      maxItems: 1
> @@ -49,17 +50,18 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    items:
> -      - description: RDMA clock
> -      - description: RSZ clock
> +    minItems: 1
> +    maxItems: 2

Keep the description here and just add 'minItems: 1' and...

>  
>    iommus:
>      maxItems: 1
>  
>    mboxes:
> -    items:
> -      - description: used for 1st data pipe from RDMA
> -      - description: used for 2nd data pipe from RDMA
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
>  
>    '#dma-cells':
>      const: 1
> @@ -68,13 +70,46 @@ required:
>    - compatible
>    - reg
>    - mediatek,gce-client-reg
> -  - mediatek,gce-events
>    - power-domains
>    - clocks
>    - iommus
> -  - mboxes
>    - '#dma-cells'
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8183-mdp3-rdma
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: RDMA clock
> +            - description: RSZ clock (shared SRAM with RDMA)

Then just need 'minItems: 2' here and...

> +
> +        mboxes:
> +          items:
> +            - description: used for 1st data pipe from RDMA
> +            - description: used for 2nd data pipe from RDMA
> +
> +      required:
> +        - mboxes
> +        - mediatek,gce-events
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8195-vdo1-rdma
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: RDMA clock

'maxItems: 1' here.

The same thing applies to mboxes.

Rob
