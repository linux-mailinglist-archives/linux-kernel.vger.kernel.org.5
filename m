Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173AB7D3E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjJWRli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjJWRlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:41:14 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA407D73;
        Mon, 23 Oct 2023 10:41:08 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so2445137a34.0;
        Mon, 23 Oct 2023 10:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082868; x=1698687668;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=41Bv19GFI0dp3UjXn4zsNgx4oX4Yzpdp0llUpY4cVik=;
        b=sf6STRMmhtI6vxDaUOFrHk9KO13sBrd1HJGwxs+RcMQpdug49L63Do4yoeyxFO55Mz
         +NZCwJnpVlQG37YNrE7hbBJjdTXT8UElznZXaGlp4cQiA4ggL+DlvpVVZiMKrUszllwI
         mFGtK4V9lNDsOd+nuSNomBbHIQmp4BELKPYsj1cAOukG+Ceb9zHnag3JJQ2QisYBV5dz
         zt9bULAYhvB3LLm6nWWB9EPmqjJbwy2aEwPEk8dcBPFiJbo9YZ6/R+c5BP/4vsSzxQT3
         eeIR4CPwoKkqM5OlN46nOdM0O0O+kly5WO/45oJ1mbgqlmUc8qxLpi7v49jMydxzXCIV
         DB9A==
X-Gm-Message-State: AOJu0YyNNSV9Wh3G8A04b97iRrzMmchNUB3hdIzmj2AFvBGNzQCSqeMt
        lCcfqkUrpOK1/6xHIAlBKw==
X-Google-Smtp-Source: AGHT+IF1LFd6rdnm4Zyq9zPkgqqNnfACBtz9e9mwvvEY869hZWaxoncCuhA73fhcz/iEFjabWrHRPg==
X-Received: by 2002:a05:6830:34a4:b0:6b9:a6ef:2709 with SMTP id c36-20020a05683034a400b006b9a6ef2709mr12287668otu.8.1698082867622;
        Mon, 23 Oct 2023 10:41:07 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6e0:8169:8cd7:6070:de02:c079])
        by smtp.gmail.com with ESMTPSA id f21-20020a056830205500b006b753685cc5sm1501499otp.79.2023.10.23.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:41:06 -0700 (PDT)
Received: (nullmailer pid 864634 invoked by uid 1000);
        Mon, 23 Oct 2023 17:40:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     Thorsten.Kummermehr@microchip.com, casper.casan@gmail.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, UNGLinuxDriver@microchip.com,
        linux-doc@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
        andrew@lunn.ch, rdunlap@infradead.org,
        horatiu.vultur@microchip.com, Nicolas.Ferre@microchip.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, davem@davemloft.net, edumazet@google.com,
        Woojung.Huh@microchip.com, netdev@vger.kernel.org,
        steen.hegelund@microchip.com, corbet@lwn.net
In-Reply-To: <20231023154649.45931-10-Parthiban.Veerasooran@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-10-Parthiban.Veerasooran@microchip.com>
Message-Id: <169808266366.861355.6966014557522700866.robh@kernel.org>
Subject: Re: [PATCH net-next v2 9/9] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Date:   Mon, 23 Oct 2023 12:40:49 -0500
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


On Mon, 23 Oct 2023 21:16:49 +0530, Parthiban Veerasooran wrote:
> Add DT bindings for Microchip's LAN865X 10BASE-T1S MACPHY. The LAN8650/1
> combines a Media Access Controller (MAC) and an Ethernet PHY to enable
> 10BASE‑T1S networks. The Ethernet Media Access Controller (MAC) module
> implements a 10 Mbps half duplex Ethernet MAC, compatible with the IEEE
> 802.3 standard and a 10BASE-T1S physical layer transceiver integrated
> into the LAN8650/1. The communication between the Host and the MAC-PHY is
> specified in the OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6).
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  .../bindings/net/microchip,lan865x.yaml       | 101 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan865x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/microchip,lan865x.yaml:21:53: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/microchip,lan865x.example.dts'
Documentation/devicetree/bindings/net/microchip,lan865x.yaml:21:53: mapping values are not allowed in this context
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/microchip,lan865x.example.dts] Error 1
./Documentation/devicetree/bindings/net/microchip,lan865x.yaml:21:53: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/microchip,lan865x.yaml: ignoring, error parsing file

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231023154649.45931-10-Parthiban.Veerasooran@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

