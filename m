Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE037AFD69
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjI0H7Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 03:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjI0H7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:59:22 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF7A13A;
        Wed, 27 Sep 2023 00:59:20 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59f6763767dso85555607b3.2;
        Wed, 27 Sep 2023 00:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695801560; x=1696406360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMT1j26t8dOkRFRh4332nTiRpDFbKB81QWUMtGHO2gA=;
        b=kqUp42mMNpNq8bM9HthNz5TP9S551B3NIbNkJvCo4G1pKXVBldPyjZQlOx6cAcNDw0
         dOAqaM7pbKREnq5Sjt+77m2ad2sdStiWtWHzg3s+xf86vvtDoz1V4FKBWHtwX9GBQK9Z
         w8Ctra3+qjHUTQIHe1xRmOfqYwJt1MvLSKsL8zPJfNtWyiqAg75WrWkitkqT/cEhybiu
         7y96XQTIpoFBkSeHFfIpxKfhiLcZMG7BP2NxsAsurYceT5wdiNLgkOjXpszcEry1fhBI
         i3JNpYcDRzJQmZAzw7VxxUR6SBpZogZcu1RZCUDp/UD/EpiHdxcrSehpP+gBZaYULYI3
         B+iQ==
X-Gm-Message-State: AOJu0Yzid9Ayiwo3idVJD8ovp1qeePQ+UCbQGefZGtsqApEGwsrcGrXH
        OJd3wc/IyR2HITSk0OArEgyZk2RaMGyI3Q==
X-Google-Smtp-Source: AGHT+IF0eGSNtWdD+DoeXCyKYUNMFhixXcqM/++g+vkb5sF4JOI5Towv7P7wAzB4A+9BwpohjVMHCA==
X-Received: by 2002:a05:690c:2a81:b0:5a1:fb1d:740a with SMTP id ek1-20020a05690c2a8100b005a1fb1d740amr804324ywb.51.1695801559785;
        Wed, 27 Sep 2023 00:59:19 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id fu6-20020a05690c368600b0059590440338sm2510336ywb.43.2023.09.27.00.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 00:59:18 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59bf1dde73fso135389437b3.3;
        Wed, 27 Sep 2023 00:59:18 -0700 (PDT)
X-Received: by 2002:a0d:d784:0:b0:595:80be:fc6b with SMTP id
 z126-20020a0dd784000000b0059580befc6bmr1630689ywd.18.1695801558289; Wed, 27
 Sep 2023 00:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com> <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Sep 2023 09:59:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUibHxPBCLbeWdNrEk_szm+o4cOcskEMZAqUufNTzQKMQ@mail.gmail.com>
Message-ID: <CAMuHMdUibHxPBCLbeWdNrEk_szm+o4cOcskEMZAqUufNTzQKMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related properties
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Tue, Sep 26, 2023 at 11:08 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The CSI IP found inside the Renesas RZ/V2M SoC can also work
> in SPI slave mode.
> When working in slave mode, the IP can make use of the SS
> (Slave Select) pin, with "low" as default active level.
> The active level of SS can be changed to "high" upon configuration.
> This patch adds two new properties, one to make use of the
> SS pin when in slave mode, and one to make the SS pin active high.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/spi/renesas,rzv2m-csi.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,rzv2m-csi.yaml
> @@ -39,6 +39,17 @@ properties:
>    power-domains:
>      maxItems: 1
>
> +  renesas,csi-ss:
> +    type: boolean
> +    description:
> +      Use CSI Slave Selection (SS) pin to enable transmission and reception when
> +      in slave mode.

Can't this be done in a more generic way? I had expected that the
existing SPI_NO_CS flag can be set using a property in the "slave" subnode,
but apparently there is no "spi-no-cs" property defined yet.

> +
> +  renesas,csi-ss-high:
> +    type: boolean
> +    description:
> +      The SS pin is active high (by default the SS pin is active low).

Can't you use the "spi-cs-high" property in the "slave" subnode instead?

> +
>  required:
>    - compatible
>    - reg

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
