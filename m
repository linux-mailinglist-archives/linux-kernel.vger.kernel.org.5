Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8E7DD59F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376562AbjJaRzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345368AbjJaRzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:55:33 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF58FC1;
        Tue, 31 Oct 2023 10:55:28 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b2f2b9a176so3871891b6e.0;
        Tue, 31 Oct 2023 10:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774928; x=1699379728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cghi8HzRqMQtZYMVfq+8g/GwoACch6SchmkRjnW1zRM=;
        b=wlD4gYilShyvpxIcWnXmiZo8ftYC563a84DEvWEiJ7hzs2sJEG+lKwk3undp/gCW92
         8LjF0Y4Vy+Y2vCuFnFZSo0K5owgzwQd7/maLL19KNbOyrhwwEXtB3crPMAV2kgp3IpqD
         fTjCqq2YTfhYbB4askukA/mVmQm8yWFzV/zeftQZr1Rhb/5WVGXoCV1ji9d72hhR8jzV
         PFXk4va3QA+NiH6ryVzo13RYU+RNUsh4oBpN6KvmMFCc6gk7FL3fdDArgxwGpwOqXVgX
         9T4WOjbP6s0sFAWqdqe0yoOL9aYf+D2sR4bh8Scd102C7ZPra3jDi1T1Zc50GNUSY5Xf
         Zy3A==
X-Gm-Message-State: AOJu0YxmMDCrfRsP1pAI9iXIWCTW7qaCM4VYxX6NoxzqzocnERxLStGJ
        EqM44dVryih+cOUyIxf0ZA==
X-Google-Smtp-Source: AGHT+IEzgDoWb29ZJLyxAQR/UtzwH60FOikEPz4ULoPEiWOeX2qzVl3h09iHl3uA/9qvyP/m3aTQpw==
X-Received: by 2002:aca:d03:0:b0:3ae:126b:8bfc with SMTP id 3-20020aca0d03000000b003ae126b8bfcmr13403099oin.4.1698774928201;
        Tue, 31 Oct 2023 10:55:28 -0700 (PDT)
Received: from herring.priv ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id z3-20020a056808048300b003b2e7231faasm328109oid.28.2023.10.31.10.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:55:27 -0700 (PDT)
Received: (nullmailer pid 1810151 invoked by uid 1000);
        Tue, 31 Oct 2023 17:55:26 -0000
Date:   Tue, 31 Oct 2023 12:55:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Airlie <airlied@gmail.com>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: Re: [PATCH v9 03/16] dt-bindings: media: mediatek: mdp3: add config
 for MT8195 RDMA
Message-ID: <169877492598.1810050.14443640728512842209.robh@kernel.org>
References: <20231031083357.13775-1-moudy.ho@mediatek.com>
 <20231031083357.13775-4-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031083357.13775-4-moudy.ho@mediatek.com>
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


On Tue, 31 Oct 2023 16:33:44 +0800, Moudy Ho wrote:
> Added the configuration for MT8195 RDMA. In comparison to MT8183, it
> no longer shares SRAM with RSZ, and there are now preconfigured 5 mbox.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/media/mediatek,mdp3-rdma.yaml    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

