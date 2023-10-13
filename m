Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C47C8ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjJMVMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjJMVME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:12:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56646BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:12:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b64b98656bso399375066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697231522; x=1697836322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UHVs5ZMbCMnK4OZxIw3w4X3jAnHxQSIJjis2sL1D3HI=;
        b=dO1GIqemepXjKGmg3lbpqPOar2nZH1kZ3q1HZ8PumN652eubsrxfpovlesXbIiWea0
         TzSK2tE9GRnVgJeuN20VbS+sZHfKhw3w+DFLwOQnJunWnKtmFzcEQYy4h7I6unhWhjTC
         DXnucm7AwN6816jyQ1rZ9l7EM9k0vKpfyUaio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231522; x=1697836322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHVs5ZMbCMnK4OZxIw3w4X3jAnHxQSIJjis2sL1D3HI=;
        b=qAUAJA2aJwGTt2JoTjq9FsXtc+JCuxLXr4Fa6i9K27xztkVMS9EGrYMe3IXUjjl00S
         dEvaWEIEXE5qc+Pd8scmcQyjNwNwD0uHGvxdqxXc7i4AxGD5DEnnkve27gRz2rnPY1S0
         w2x/OMolkIkSNgHr8S0ne+L0IN4m4tHgeaGYOxH4Wqo1TAfRfCzX5I6k6UgDTa+qZ/2T
         mbmzAgH6AeC5VhsME7y/8MvzpEA8nIxXgU+/WIRbPCF6aIPWPX2AM5ArNQ6SYHJESBKB
         uauVOqS4y7DkK+pMvSCNHssGYSr1sHUKF9qQcq5pyBnPg8+Qh0TnDXxdk+8vd7mKAa5B
         UTQA==
X-Gm-Message-State: AOJu0Yychjp6/FEyOcaqIyKiFYnj7j5b3FZkIZlkgcEpLwQNwh7f38S+
        L0pAxMNRIAZXHvYUv5QpE7beRqCCx7SrpMdIlvT0MQ==
X-Google-Smtp-Source: AGHT+IEuNA+Q2Yxxws7amOJuXWe3ey6jbnUkGbWIJda+AVzB6s8jOrXT89FhBxT8kIo26PoR154bP2xzv0Ano/B3pdA=
X-Received: by 2002:a17:907:60cb:b0:9be:7b67:1673 with SMTP id
 hv11-20020a17090760cb00b009be7b671673mr337821ejc.1.1697231521525; Fri, 13 Oct
 2023 14:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231013200851.347042-1-robh@kernel.org>
In-Reply-To: <20231013200851.347042-1-robh@kernel.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Fri, 13 Oct 2023 14:11:50 -0700
Message-ID: <CAPnjgZ0Uh7RTvYfLjEL7g1NjC1pO8-xJuj9RBSVVnwviAwzF0Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Drop kernel copy of common reserved-memory bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Julien Massot <julien.massot@iot.bzh>,
        Trevor Wu <trevor.wu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 at 13:45, Rob Herring <robh@kernel.org> wrote:
>
> The common reserved-memory bindings have recently been copied from the
> kernel tree into dtschema. The preference is to host common, stable
> bindings in dtschema. As reserved-memory is documented in the DT Spec,
> it meets the criteria.
>
> The v2023.09 version of dtschema is what contains the reserved-memory
> schemas we depend on, so bump the minimum version to that. Otherwise,
> references to these schemas will generate errors.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/Makefile    |   2 +-
>  .../remoteproc/renesas,rcar-rproc.yaml        |   2 +-
>  .../bindings/reserved-memory/framebuffer.yaml |  52 -----
>  .../reserved-memory/memory-region.yaml        |  40 ----
>  .../reserved-memory/reserved-memory.txt       |   2 +-
>  .../reserved-memory/reserved-memory.yaml      | 181 ------------------
>  .../reserved-memory/shared-dma-pool.yaml      |  97 ----------
>  .../bindings/sound/mediatek,mt8188-afe.yaml   |   2 +-
>  8 files changed, 4 insertions(+), 374 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml
>  delete mode 100644 Documentation/devicetree/bindings/reserved-memory/memory-region.yaml
>  delete mode 100644 Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
>  delete mode 100644 Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
>

Reviewed-by: Simon Glass <sjg@chromium.org>
