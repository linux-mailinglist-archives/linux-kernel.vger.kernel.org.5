Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB67CCA42
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbjJQSCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344034AbjJQSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:02:07 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F7683;
        Tue, 17 Oct 2023 11:02:06 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57bb6a2481fso3060990eaf.1;
        Tue, 17 Oct 2023 11:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697565725; x=1698170525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4zSULC6tYMgDwlefy398CqYouEt1PnTsePlXraWRwY=;
        b=k5w9WZvMvyIO9im3T7XCX266g7D6lIqTHWUJXXKiLuAo1EdKyt5Hbrt/n03s7dD/Y+
         zAth+CwLqsPyYCenzmJrR/qboauMEKQeg+TXF8d+KybD8fKVsWmFyStIsDIkhMLzHLAi
         kC71owqfhUTELUJoiawiczC38/xnVM+oGBLVreiDYzmDjFxWneD1PQ7jBudYOLZwsK3Y
         ACngN5aShd6AAqJUs36P4g6arOi2R9tGqATeduEAOeu5XYvynsw7qOfkRgAloo/G7TVE
         2nevxv8kXJANAD/aCQRf7eUWAPPBfWvVzxlqn1oD/7Gs9Bnlj4Vl7oEV3mtDxfWY5i/g
         nZUw==
X-Gm-Message-State: AOJu0YwGz7LQ3TIs4AtyKuXUxeRD9IZRX89h+9pcSBQgMNAAICBhrReP
        2pN0xGNfK9DjHoBknS/P7Q==
X-Google-Smtp-Source: AGHT+IGYl8NsMkmCWHJctENv7BLQKSIPldaRQB0sk7RLckjACR2AvUCECrB9fvNpYtIpkzrJ9wTehg==
X-Received: by 2002:a4a:dc8f:0:b0:581:9066:49 with SMTP id g15-20020a4adc8f000000b0058190660049mr3213971oou.0.1697565725294;
        Tue, 17 Oct 2023 11:02:05 -0700 (PDT)
Received: from kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bb33-20020a056820162100b0057bb406dc31sm320402oob.2.2023.10.17.11.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:02:04 -0700 (PDT)
Date:   Tue, 17 Oct 2023 13:02:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH V5] dt-bindings: Add Marantec vendor prefix
Message-ID: <169756572090.2244887.15600668745930981170.robh@kernel.org>
References: <20231016150415.3196-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016150415.3196-1-cniedermaier@dh-electronics.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Oct 2023 17:04:15 +0200, Christoph Niedermaier wrote:
> Add vendor prefix for Marantec electronics GmbH.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
> V2: - Add this patch to the series
> V3: - Add Acked-by tag
> V4: - No changes
> V5: - Rebase on current next 20231016
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!

