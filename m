Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD257600D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjGXVCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:02:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62410E67;
        Mon, 24 Jul 2023 14:02:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E827D61411;
        Mon, 24 Jul 2023 21:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A62EC433D9;
        Mon, 24 Jul 2023 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690232558;
        bh=0+Srw7lXT1FA8YIDbGu44docy330MM50fqmGEpJ5PiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eF880e10xh6n475OZjp5F/Po8sUNB+6EBgxnJbCsEXZK3RaXYlY+t3JoJzkMC5CUV
         TjA2GwYkIaFbjR1iRd1y7TXm/mEDexVUie/0iU3huXUxbyhN26riJMpZt88FNvDvi9
         Kcn4MX3KpjJRaA2BATIpZHbS0sqACpdYlP4WIwC5h6aN/paMxhVY/+7BrzUQA+21/g
         gcyzj9jR3ZFeArfjNVuNqDSCaXTcvgFcl3deDvxjOawX9gsXagFytQPlAgnZPRDfeP
         kYdOd5rTcMWpbV8TEl1op6AUBrzBkzavsxry0ellreSDbh0UxUKUUqvfeB8B1OIsUo
         XRipzVZd0M7+Q==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b7430bda8bso70538321fa.0;
        Mon, 24 Jul 2023 14:02:38 -0700 (PDT)
X-Gm-Message-State: ABy/qLZwkQSTkS3vn0blE4KPAI18RpQFkPumnouB2gfqExRwWL5NLaFP
        BcDMSF+j57OATqZczONwoREfNyehKiNnwNu/BQ==
X-Google-Smtp-Source: APBJJlG02/cT58K6TBy2dpTL5aTHIezcfXvz2TD3qAfXrj44uyTbqvpoDx2CALCp5CDzH8HFqOlm6YDCvEHlbpVDOSQ=
X-Received: by 2002:a2e:924b:0:b0:2b6:e536:a2a3 with SMTP id
 v11-20020a2e924b000000b002b6e536a2a3mr7171152ljg.19.1690232555975; Mon, 24
 Jul 2023 14:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230723071105.40157-1-krzysztof.kozlowski@linaro.org>
 <20230724162638.GA3784203-robh@kernel.org> <60e7e772-bf0a-264d-abac-4ed72766a2d0@linaro.org>
In-Reply-To: <60e7e772-bf0a-264d-abac-4ed72766a2d0@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 24 Jul 2023 15:02:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLwZR_VQEAuhLLqN4BF8Yvh=3vkQe=tFHaKWzJzMMP+qw@mail.gmail.com>
Message-ID: <CAL_JsqLwZR_VQEAuhLLqN4BF8Yvh=3vkQe=tFHaKWzJzMMP+qw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: add missing unevaluatedProperties on
 USB connector
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jagan Sridharan <badhri@google.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Min Guo <min.guo@mediatek.com>,
        Gene Chen <gene_chen@richtek.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:05=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/07/2023 18:26, Rob Herring wrote:
> > On Sun, Jul 23, 2023 at 09:11:05AM +0200, Krzysztof Kozlowski wrote:
> >> The usb-connector.yaml schema allows any additional properties, thus i=
ts
> >> usage should finish with unevaluatedProperties: false.
> >
> > Is it problematic if usb-connector.yaml is restricted?
>
> Yes, a bit.
> 1. Missing reg/unit-address:
> Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml
> I guess this could be easily solved.
>
> 2. phy-supply:
> arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> (and more of armada)
> This is a bit odd:
>
> phy@18300 {
>   compatible =3D "marvell,comphy-a3700";
>   comphy0: phy@0 {}
>   comphy1: phy@1 {}
>   comphy2: phy@2 {
>     connector {
>       compatible =3D "usb-a-connector";
>       phy-supply =3D <&exp_usb3_vbus>;
>    };
> };
>
> I would assume that phy-supply should be a property of the phy.

Indeed. We already have vbus-supply which this looks like it is. I'm
pretty sure I've seen Vbus in phy bindings too which I've pushed back
on as to whether Vbus really went to the phy or was there because the
phy driver just wants to control Vbus.

The marvell platforms aren't in great shape schema wise, so maybe
don't worry about it now.

Rob
