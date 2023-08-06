Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0438E77149B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 13:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjHFLy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 07:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjHFLy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 07:54:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3337113E;
        Sun,  6 Aug 2023 04:54:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bdf08860dso1006810466b.0;
        Sun, 06 Aug 2023 04:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691322863; x=1691927663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAUVVtQckGSREQLgmuK8h29UmATiSd20iBySdHbiIh4=;
        b=gUo7jbm9bh76bkPZX/Z0kQAzHVRJackKP4ZtSz11IrpqXLWpxF9bNzuWtR9iIRsqQ5
         12DYw/FvVo6QXliotikaPwS9MY1FOh04dFSRfMt4zPU4jxlaPL/hq9ye1vrxL8a8U8f5
         zoWac5JXlXKsDV+Uh/YNxF/f5FwLCzk3rF69AFQtcrWK+oNN63VjpLXwmu1tf3SB24E7
         DWhcyx8Ddh3MYyYEVsTc+xT9llVe8umvWfqAs7tQb9f6Ai/TZ5BqMp4l4vXz5ZiyCbjI
         rv31XLZHzAXlbFlm+j5zlffoNPf8EV+gAgRQicHSSydqrPMOYaEUvq4ukdxJr75+9LuH
         +0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691322863; x=1691927663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAUVVtQckGSREQLgmuK8h29UmATiSd20iBySdHbiIh4=;
        b=VLrRJ2WtaRETkTjMt/xjeATFEL4SwtlmZxv3DEcEJ4ry0P1DI+hvMppjyZv+qJsUR2
         dg2pVpxHYPc/CP3rBtfy517L+3IX7I2AX1tMVJwWNwBSMFlR4IZYmYL8un+PRy7P1Bmv
         3WMy2NR1avZ70RIPoa7+V8qUPNV9xOGuUdqGb1utqf2fSFPftxEl6k3n5s7LqdVclxan
         H5giOJq6KaV5JaDiIxWlTq1FsXhX7P5TO0s3LiPpx9naz5lfxFsk4AzAaTgahucQ1prd
         LzWzAtzPYbkOHUJtTDh0MG7AJkW678oCrYdXYhsdIaEYKZEdqujG1H90YTCU/x15pGso
         S78w==
X-Gm-Message-State: AOJu0YzbYXt8FY91QOBulbKi9OeUmwckTPjhOLUFZ3H+QfzsUIxF1vNe
        P0ziTEo/FZW1sw8LeCElmpA=
X-Google-Smtp-Source: AGHT+IGATIlbp6aIPzaEjeWTR1B9gwvSMjcwOW32pblUk/H4WHTy6XDY799Ix40sXxfvkW+7th6OKw==
X-Received: by 2002:a17:907:9620:b0:99b:56d4:82bb with SMTP id gb32-20020a170907962000b0099b56d482bbmr5133754ejc.6.1691322863585;
        Sun, 06 Aug 2023 04:54:23 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090636cd00b0099bcf9c2ec6sm3879286ejc.75.2023.08.06.04.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 04:54:23 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     martin.botka1@gmail.com, Martin Botka <martin@biqu3d.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Martin Botka <martin@biqu3d.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Add BigTreeTech CB1 SoM & Boards
Date:   Sun, 06 Aug 2023 13:54:21 +0200
Message-ID: <3242042.aeNJFYEL58@jernej-laptop>
In-Reply-To: <5EB3DB1D7F80A40F+20230805083636.788048-1-martin@biqu3d.com>
References: <5EB3DB1D7F80A40F+20230805083636.788048-1-martin@biqu3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 05. avgust 2023 ob 10:36:03 CEST je Martin Botka napisal(a):
> Hello,
> This series adds a vendor prefix for BigTreeTech and adds BigTreeTech CB1,
> Manta board and BigTreeTech Pi.
> 
> CB1 is just an SoM thats based on AllWinner H616.
> BigTreeTech Manta boards are expander boards for CB1 and BigTreeTech Pi
> is an CB1 in Rpi style with few additional things like IR receiver and fan
> port on GPIO.
> 
> This work started before I was hired by BigTreeTech and thus majority of the
> patches are from SoMainline email and few are from my work email.
> 
> This series depends on commit https://lkml.org/lkml/2023/8/2/801
> "dt-bindings: mfd: x-powers,axp152: make interrupt optional for more chips".

What's the status of above patch?

I won't merge this series until it's accepted and merged.

Best regards,
Jernej

> 
> Cheers,
> Martin
> 
> Martin Botka (4):
>   dt-bindings: vendor-prefixes: Add BigTreeTech
>   dt-bindings: arm: sunxi: Add BigTreeTech boards
>   arm64: dts: allwinner: h616: Add BigTreeTech CB1 SoM & boards support
>   arm64: dts: allwinner: h616: Add BigTreeTech Pi support
> 
>  .../devicetree/bindings/arm/sunxi.yaml        |  11 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/allwinner/Makefile        |   2 +
>  .../sun50i-h616-bigtreetech-cb1-manta.dts     |  35 +++++
>  .../sun50i-h616-bigtreetech-cb1.dtsi          | 140 ++++++++++++++++++
>  .../allwinner/sun50i-h616-bigtreetech-pi.dts  |  70 +++++++++
>  6 files changed, 260 insertions(+)
>  create mode 100644
> arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts create
> mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> create mode 100644
> arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts




