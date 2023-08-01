Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76576AB44
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjHAInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjHAIno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:43:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C75210E;
        Tue,  1 Aug 2023 01:43:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so71002161fa.2;
        Tue, 01 Aug 2023 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690879421; x=1691484221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BhvIkOiG+uMZP4JM+69r8ne1565zMfKwFxHIBxYWbGc=;
        b=IDDSX87IPAkTalI67D61h5tIyLTjxttmxUnHRhNjLPYjcBJNaIzRMNp69DasxuB5Al
         rQminpqHAm1lpPcAPtxr7y44tfK2G6BgwLckF/tuz4qJ78C9UMn5RQuJTy2cZT4F18eK
         e/BIiACegaTRRNZLvT3lcVDmEFY2rJBB319FSPbEvPF2dzFbtwK4GiBqkVFnF8amlt60
         RhaSXZdRr2ekB0txYQp187qho0jN3zaKdUktix7JOe6M0hDEzEOWcUNlU+ewDr8RQsFj
         1Vn5xR4Sn4zeD0x9cBq7GvtY8wFDpq7e2mlABkW4F54h9DzJJHD8116wjvr4zSzsC7r7
         YV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690879421; x=1691484221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhvIkOiG+uMZP4JM+69r8ne1565zMfKwFxHIBxYWbGc=;
        b=PypaTJsHnMmwjXvbLAiMM9PvipVGnljROYxrafzog+5HExHlicRPm+Ok1JcTyIZbVy
         ShBDz4nGd/xPbPDprrNhN8NAScfZ7m1gJ9ru5Qs421LScv8OECrUFDPJn2EQyQnChXEF
         HGq1v6yJhc9zRvPgg2VW6tvNWVM2hpVSgzYKvSekjkViIzn13YDnOwJBkbJN8bE6XLIy
         1/pM/mMzuqSrLq1/z1YcBnyehdy++2do6k/xB9kwT3UrEJwHF6OrKPpUK/rjniKHetj8
         DIEL2xgevAr5sz2X1WE1SDSj5wduxwrUQDjvfptfnejSb1YOgxcNKCEih+TMStdRTXBL
         6+ow==
X-Gm-Message-State: ABy/qLa2dOKow6wU1aHgRPyksD4M7qFQ2nw3jXIJTQxAfah/lSX/HJxl
        TU6WxmvbgYthgQ065uhBy2uMmRYfO/VB9QmEk3M=
X-Google-Smtp-Source: APBJJlGP+ZMsioTtAzbRr4O83nVEXbsaQizCIVfpIplEbXKQzu3K25pK10ZvNvh+aTt+A79RzUyarnk4SQNfB1LDr1o=
X-Received: by 2002:a2e:9dc7:0:b0:2b9:412a:111d with SMTP id
 x7-20020a2e9dc7000000b002b9412a111dmr1895155ljj.42.1690879421368; Tue, 01 Aug
 2023 01:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230727202126.1477515-1-iwona.winiarska@intel.com> <20230727202126.1477515-5-iwona.winiarska@intel.com>
In-Reply-To: <20230727202126.1477515-5-iwona.winiarska@intel.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 1 Aug 2023 11:43:30 +0300
Message-ID: <CAP6Zq1hsuwCtNhmwiMgB1f_S0DSs6vX=8fZC+0LaHuVoJgkmog@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: nuvoton: Add PECI controller node
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iwona,

I have done r-b, could you do a small modification

On Thu, 27 Jul 2023 at 23:23, Iwona Winiarska <iwona.winiarska@intel.com> wrote:
>
> Add PECI controller node with all required information.
>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> ---
>  arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> index aa7aac8c3774..b8326bbe9fde 100644
> --- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> @@ -68,6 +68,15 @@ apb {
>                         ranges = <0x0 0x0 0xf0000000 0x00300000>,
>                                 <0xfff00000 0x0 0xfff00000 0x00016000>;
>
> +                       peci0: peci-controller@100000 {
Please modify the peci0 to peci we have only one PECI controller.
> +                               compatible = "nuvoton,npcm845-peci";
> +                               reg = <0x100000 0x1000>;
> +                               interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clk NPCM8XX_CLK_APB3>;
> +                               cmd-timeout-ms = <1000>;
> +                               status = "disabled";
> +                       };
> +
>                         timer0: timer@8000 {
>                                 compatible = "nuvoton,npcm845-timer";
>                                 interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> --
> 2.40.1
>

Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>

Thanks,

Tomer
