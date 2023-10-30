Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0D7DC067
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjJ3T0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3T0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:26:34 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE7CC;
        Mon, 30 Oct 2023 12:26:32 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1ea98ad294cso2097425fac.3;
        Mon, 30 Oct 2023 12:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693992; x=1699298792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/Mg5F6La/20y5nY7HjoLsNGzq3KbPcPoL2CAQLIaos=;
        b=JCpfJOG6YB+CoL/cnNGF8kHovLQKbQWDGCgqIvDIpoiiiJP6+rZPJSmoOXksqWnkkF
         VijWeLv1Oln8E4STg7HOVXRevTWDC3K7D4Qa7jUKJ3ubQJ4Nu5thRHW9dMGlDRnnwVGd
         brhsPHBVxuproXFLOAMi5a3w+QZm9PLaXyOPqH/t4c/a4H38vJ8nY9x+38lmdVU3ol5P
         9jD7pIppiNE7qnuesGy7/F0COqQOulzHjgkU+9bqJQ+N8f5LnVZQ7mqi1LM9LBykypvT
         WCpjwO5WjcdDc93NwCSTdna7uaCWRFft6numethvqnwf/ezb+y3hTqRhKoHv0Ytx1Maz
         CxzQ==
X-Gm-Message-State: AOJu0YwdEkjdf7YcF1VNE+OHK5fyEgrxvLdWqD1lJ6fKBDLWixx4c07t
        Z44insxryak+6uKM+ob0Zw==
X-Google-Smtp-Source: AGHT+IGjMO5D8Ov5wU38v/9/dkRYq9nZFsMu08o0lQAqpCGW3B8LLDEUaF6w7sann/7TDndLmBvhpA==
X-Received: by 2002:a05:6870:35d0:b0:1ea:2447:5181 with SMTP id c16-20020a05687035d000b001ea24475181mr9546452oak.9.1698693991826;
        Mon, 30 Oct 2023 12:26:31 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6c7:c3eb:a6fd:69b4:aba3:6929])
        by smtp.gmail.com with ESMTPSA id lh5-20020a05687c350500b001eace5491c8sm1694876oac.18.2023.10.30.12.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:26:31 -0700 (PDT)
Received: (nullmailer pid 1991165 invoked by uid 1000);
        Mon, 30 Oct 2023 19:26:29 -0000
Date:   Mon, 30 Oct 2023 14:26:29 -0500
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
Subject: Re: [PATCH v8 03/16] dt-bindings: media: mediatek: mdp3: add config
 for MT8195 RDMA
Message-ID: <20231030192629.GA1979065-robh@kernel.org>
References: <20231030100022.9262-1-moudy.ho@mediatek.com>
 <20231030100022.9262-4-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030100022.9262-4-moudy.ho@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 06:00:09PM +0800, Moudy Ho wrote:
> Added the configuration for MT8195 RDMA. In comparison to MT8183, it
> no longer shares SRAM with RSZ, and there are now preconfigured 5 mbox.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/media/mediatek,mdp3-rdma.yaml    | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> index c043204cf210..504334a76fb3 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> @@ -22,6 +22,7 @@ properties:
>    compatible:
>      enum:
>        - mediatek,mt8183-mdp3-rdma
> +      - mediatek,mt8195-mdp3-rdma
>        - mediatek,mt8195-vdo1-rdma
>  
>    reg:
> @@ -58,7 +59,7 @@ properties:
>  
>    mboxes:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 5
>  
>    interrupts:
>      maxItems: 1
> @@ -98,6 +99,29 @@ allOf:
>          - mboxes
>          - mediatek,gce-events
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8195-mdp3-rdma
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: RDMA clock
> +
> +        mboxes:
> +          items:
> +            - description: used for 1st data pipe from RDMA
> +            - description: used for 2nd data pipe from RDMA
> +            - description: used for 3rd data pipe from RDMA
> +            - description: used for 4th data pipe from RDMA
> +            - description: used for the data pipe from SPLIT

Following the prior comments, add these entries to the top-level 
'mboxes' and then here just put 'minItems: 5'.

Rob
