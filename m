Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0BE7DD59B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376382AbjJaRzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjJaRzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:55:10 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D86A6;
        Tue, 31 Oct 2023 10:55:08 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ce2cc39d12so3744138a34.1;
        Tue, 31 Oct 2023 10:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774907; x=1699379707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sOmvixHfQMEf6cSX5X+V5dJf4sK0eb9T02qoOsLX1I=;
        b=FO0DL21WDHCdAGVFATNdly/5OFFh7Hpt5U+TFHNvqjR9/0Zgti8LWEsn2Ef24T6U56
         354MzH3xoZoUeHAtEFXV/OD55uB/bC6unjDq/Zc5XOoaTH+gTSfFMEP+/DgCVRX0IbvM
         CjWBw/9Fjcd2cLpApgMhjXOXpNMctqSdWVERjgwzvJlxJRlrRopVlOL5J3hZ4UHEooJF
         XWa4jAGFrtoGmCtExfsKGultsJC3xsa4F7lixn8hSanFtNuUUwA/y9dinlRsH9QFJnk9
         GIQIvcWSUrt0EPujfz2EHtIAbRP11WCVSpjlu+qpy9tMlIBXQVF9L9fG7rYjO6eWhsJi
         94RQ==
X-Gm-Message-State: AOJu0YyWGzmDI4JuRCZg4GAEdd3CmWP6JQ8kDyt2nm0y4QKBSoDvTOEJ
        hiKZxbrCQ8IbuBp/TyqCWA==
X-Google-Smtp-Source: AGHT+IFmuj30SZPqXu2EIXyI7kKLettnOwn2LVc9BC4D5MXj13OHIw3L94S9nKTG5g66A8WPtZAtEA==
X-Received: by 2002:a05:6870:cd93:b0:1e9:97cc:59ff with SMTP id xb19-20020a056870cd9300b001e997cc59ffmr16786765oab.9.1698774907268;
        Tue, 31 Oct 2023 10:55:07 -0700 (PDT)
Received: from herring.priv ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870034100b001e9b02b00e9sm368369oaf.22.2023.10.31.10.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:55:06 -0700 (PDT)
Received: (nullmailer pid 1809590 invoked by uid 1000);
        Tue, 31 Oct 2023 17:55:05 -0000
Date:   Tue, 31 Oct 2023 12:55:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>, linux-media@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v9 02/16] dt-bindings: media: mediatek: mdp3: merge the
 indentical RDMA under display
Message-ID: <169877490486.1809532.9023561200743242448.robh@kernel.org>
References: <20231031083357.13775-1-moudy.ho@mediatek.com>
 <20231031083357.13775-3-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031083357.13775-3-moudy.ho@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Oct 2023 16:33:43 +0800, Moudy Ho wrote:
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
>  .../bindings/media/mediatek,mdp3-rdma.yaml    | 42 ++++++++-
>  2 files changed, 38 insertions(+), 92 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

