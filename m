Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAFC8065C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376528AbjLFDjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376518AbjLFDjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:39:46 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10BD46;
        Tue,  5 Dec 2023 19:39:52 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1fae0e518a4so237817fac.0;
        Tue, 05 Dec 2023 19:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701833991; x=1702438791;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJIWxQKQmoNjd89AOA5RvXC8o59/K2/mf5I5lOAD10o=;
        b=Xdrga9hN+lydmxzHm+b4FsZGXR2D8XOmni1fyy0NfXrzLVWFSRDKUMYo2q9J7KwlrS
         5Xae7qDy++kRtsrDqLTNWwXuj1kZrRo4UZMgdyX5kn1OhI36cF6BcfE5QpsnhQlvt0VD
         40QVOvPlXLm9PP7fGlsoopHY15ffKXaoct5nkz2wQhkG8h++BrjKDXZsunYJcQvCHGnv
         phveVCwEIwMR9S4Z+09SeSwkyCBaxTpkJ7dgtkLnnx/rOv/r0+FL1LWIyzwU1JjZ+7k7
         PZRXyyf2KONS90X3y+6FSIO9OXgi3vs/T5Lb8PwqU87ASINDUj2WjPs/58WE1L6pYteU
         eKyg==
X-Gm-Message-State: AOJu0YyNxshTUm2GH/5lD/MvTK1q2Ec8o7hUFOY5X5WLTOgPatw474XT
        MMyh/DcSqTbOF2Jjj0dlYw==
X-Google-Smtp-Source: AGHT+IHKIuDZkUJdhycFI25RBd55iQTufoFG0amrVDo68Zz7yH3kYl4TC99m4aOnfpMln9254UTV5w==
X-Received: by 2002:a05:6871:4087:b0:1fb:75a:678c with SMTP id kz7-20020a056871408700b001fb075a678cmr145094oab.51.1701833991728;
        Tue, 05 Dec 2023 19:39:51 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id on7-20020a0568715a0700b001fb42001fa7sm1462872oac.36.2023.12.05.19.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 19:39:50 -0800 (PST)
Received: (nullmailer pid 463139 invoked by uid 1000);
        Wed, 06 Dec 2023 03:39:36 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Felix Fietkau <nbd@nbd.name>,
        Eric Dumazet <edumazet@google.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-phy@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qingfang Deng <dqfext@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Crispin <john@phrozen.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Lee <Mark-MC.Lee@mediatek.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Couzens <lynxis@fe80.eu>
In-Reply-To: <3cd8af5e44554c2db2d7898494ee813967206bd9.1701826319.git.daniel@makrotopia.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
 <3cd8af5e44554c2db2d7898494ee813967206bd9.1701826319.git.daniel@makrotopia.org>
Message-Id: <170183397446.463049.17564721561503446292.robh@kernel.org>
Subject: Re: [RFC PATCH v2 5/8] net: pcs: add driver for MediaTek USXGMII
 PCS
Date:   Tue, 05 Dec 2023 21:39:36 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Dec 2023 01:44:38 +0000, Daniel Golle wrote:
> Add driver for USXGMII PCS found in the MediaTek MT7988 SoC and supporting
> USXGMII, 10GBase-R and 5GBase-R interface modes. In order to support
> Cisco SGMII, 1000Base-X and 2500Base-X via the also present LynxI PCS
> create a wrapped PCS taking care of the components shared between the
> new USXGMII PCS and the legacy LynxI PCS.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/net/pcs/mediatek,usxgmii.yaml    |  46 +-
>  MAINTAINERS                                   |   2 +
>  drivers/net/pcs/Kconfig                       |  11 +
>  drivers/net/pcs/Makefile                      |   1 +
>  drivers/net/pcs/pcs-mtk-usxgmii.c             | 413 ++++++++++++++++++
>  include/linux/pcs/pcs-mtk-usxgmii.h           |  26 ++
>  6 files changed, 456 insertions(+), 43 deletions(-)
>  create mode 100644 drivers/net/pcs/pcs-mtk-usxgmii.c
>  create mode 100644 include/linux/pcs/pcs-mtk-usxgmii.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/3cd8af5e44554c2db2d7898494ee813967206bd9.1701826319.git.daniel@makrotopia.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

