Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067C477EABE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346155AbjHPUcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346197AbjHPUby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:31:54 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD2C2709
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:31:51 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d62b9bd5b03so6565419276.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692217911; x=1692822711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ESK9GO7mfDGeXFIUEzQzbG42Lacp21O8/Gw0HAGsBdg=;
        b=VoV3YZbJ7ItSImQ9pXkoIICPaoSt/NtxGqoRP7tZg5BcjHUOS8Tyu4GNPxpf50+nk4
         4re39STGcwHAduO6Sli7a5/kuJg/+eH7AkwyChhZMTEE5HAA0mYluaqDkMS4U3SxArw2
         0nqeL52kiBbp6xZyUWh+oj9+iH47sW+T8YmOIqqh0KjP1hHfgazv1DuuMKZlT0iK6wta
         RL4peN+pzUHztomypCQG0dx83XhnTH76XO7kfYvnG7vplylk5+I4x3nK34dHncVVrI/I
         mVAW3/1KlxVxbaSOyJKJCPdZYOQyKwOXh4kJjBNJakLC25VrciVePh/a1OL6IgNdjWH6
         qskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692217911; x=1692822711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESK9GO7mfDGeXFIUEzQzbG42Lacp21O8/Gw0HAGsBdg=;
        b=CEk+DKaS5r1EcweNjS9xx3z7oCpUKTg+8NoN7EOKQOxCuE4bepQyUAXs5NUiSaltf2
         QZDsi0H+OY8qMN46lJBLpw6xDvtvLAURA1Uuo24pFp9vLHQORJFbn4NRbXSdId39/wgO
         yPZTOcTJ/Q6gj5Ud1SyGj5UxW9ipUJp1eHEuB9DFOlePg2DXhSIl0RC2r4a3Wtt6MV4x
         ZQyaB+f2jy9BiOZSIfx33j9QSEITLsEbHnzoEFxdlAKcFS2R1KTmdR/IoNVeZaiB1tyx
         qvfU6iIp3ALfnbEh/LiU1BUpmTzjykof19IcVtHsE9+zfQnFsQ/wHrBmusAkBrjLi1Zf
         abCw==
X-Gm-Message-State: AOJu0Yz1pFGyMPEnwe8vhKaqEhg/H+sRTgOEnmcGU/0UXQUHn3WtCxJc
        Onao8uQz4096M0oUgEt5vadDhtSUg2M8MnPSsp6fhR0Sf2I7Gyl9R3NOrA==
X-Google-Smtp-Source: AGHT+IGeMEblFueiAliICx+pZWdnIigWVze5mzQKg70Gob/XSxTKfd2Blz1Vvb5F00DOrKg4/8UUJ/9er3xfC1Xkfqo=
X-Received: by 2002:a25:7457:0:b0:d4a:f17:88 with SMTP id p84-20020a257457000000b00d4a0f170088mr2540265ybc.61.1692217911021;
 Wed, 16 Aug 2023 13:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230816154841.2183-1-quic_nitirawa@quicinc.com> <20230816154841.2183-2-quic_nitirawa@quicinc.com>
In-Reply-To: <20230816154841.2183-2-quic_nitirawa@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 16 Aug 2023 23:31:40 +0300
Message-ID: <CAA8EJpoMFCbHuZcEN3-cxFN94QTG6wfNb52vfwuw6qLOfmdFyg@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for SC7280
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        agross@kernel.org, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 at 18:50, Nitin Rawat <quic_nitirawa@quicinc.com> wrote:
>
> Document the QMP UFS PHY compatible for SC7280.
>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> index d981d77e82e4..ad78da9c2c1a 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> @@ -31,6 +31,7 @@ properties:
>        - qcom,sm8350-qmp-ufs-phy
>        - qcom,sm8450-qmp-ufs-phy
>        - qcom,sm8550-qmp-ufs-phy
> +      - qcom,sc7280-qmp-ufs-phy
>
>    reg:
>      maxItems: 1
> @@ -110,6 +111,7 @@ allOf:
>                - qcom,sm8250-qmp-ufs-phy
>                - qcom,sm8350-qmp-ufs-phy
>                - qcom,sm8550-qmp-ufs-phy
> +              - qcom,sc7280-qmp-ufs-phy

Please keep both lists sorted.

>      then:
>        properties:
>          clocks:
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
