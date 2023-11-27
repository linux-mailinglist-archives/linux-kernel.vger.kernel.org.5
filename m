Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502727FA85C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjK0RxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjK0RxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:53:06 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C550B6;
        Mon, 27 Nov 2023 09:53:13 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-58d54612d9cso1220577eaf.1;
        Mon, 27 Nov 2023 09:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701107592; x=1701712392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXEZGcv8bSxQjKfcCrALAvNXAs+CKpToCxY7DnKjWaE=;
        b=XFZa7zWqCi5ksV2SE5Cp9rR38xDuJHr5hEJyxeREMN0RjAajWVNX4H08C44+VNOj0T
         2Oh8jL98JlWy5TN+xVKKtW0wBtlZSEa2kIxiqsoKUMDGJ4gFbJtg5jKTULy0qB7pPjDs
         Ms377jNZ5oYyCc9kULSsewWaUL0tZZLsF6bl4FJK+hOG//rHFs/cEYJRAqtdxOCjXybq
         P0jnXK9DtbROMrpc7Zm7YVN2WMglVwwZFFQX0H9U6frUtVto8Nxw1YMHZP7xIjvQpAsS
         ohCh+cKRMDCvZFBB6s1DP8aEhZm3bYJdyZ9tR16cDgc0ANN8c4t1Y3/AxX068nzqJOIW
         Cbyg==
X-Gm-Message-State: AOJu0YyJO32OVe5U4d8i+11LaVBH1927/O1t4chxX/EhPowl+BCIWhg9
        +kyU1OwB8t5RKWXLpUEUhw==
X-Google-Smtp-Source: AGHT+IHqCcFjtcM7hpVFdO1GU5tjNNQyP+pOeAzsBXWkues29+89h8GwQNH+gICSaOfRfB6G2/lWGA==
X-Received: by 2002:a05:6820:514:b0:58d:9d79:abc with SMTP id m20-20020a056820051400b0058d9d790abcmr2490913ooj.1.1701107592638;
        Mon, 27 Nov 2023 09:53:12 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i14-20020a4aab0e000000b0057327cecdd8sm1545477oon.10.2023.11.27.09.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:53:11 -0800 (PST)
Received: (nullmailer pid 1865094 invoked by uid 1000);
        Mon, 27 Nov 2023 17:53:10 -0000
Date:   Mon, 27 Nov 2023 11:53:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        Jitao Shi <jitao.shi@mediatek.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: display: mediatek: dsi: remove Xinlei's mail
Message-ID: <170110758909.1864817.4462999891137574457.robh@kernel.org>
References: <20231123134927.2034024-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123134927.2034024-1-mwalle@kernel.org>
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


On Thu, 23 Nov 2023 14:49:27 +0100, Michael Walle wrote:
> Xinlei Lee's mail is bouncing:
> 
> <xinlei.lee@mediatek.com>: host mailgw02.mediatek.com[216.200.240.185] said:
>     550 Relaying mail to xinlei.lee@mediatek.com is not allowed (in reply to
>     RCPT TO command)
> 
> Remove it.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.yaml       | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!

