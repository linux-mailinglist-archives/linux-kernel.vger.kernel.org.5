Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D1F7D3DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjJWRlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjJWRk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:40:57 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185FF10A;
        Mon, 23 Oct 2023 10:40:55 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ce327458a6so1858126a34.1;
        Mon, 23 Oct 2023 10:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082854; x=1698687654;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ILqe4UeRsi+xHDEWjuo1948g/BLlUzJNRphfa9L6WoM=;
        b=g1jW8Y2XDgoRiGO8Q2DiSkYIePx4JmI28oBxMkix2zYNdM2wVsGxhhyVeKc5dsimSk
         MFzsHzODwKPXKqN8EBg6bXTxpLOfKeIXdpBEx+oIBx6wbSz0eQXP5vhLxhb+gITISmdd
         Qgo2hl7W90cXcqIGACWG4zhW01kL3poua38dx49uPyy7ag+PmysWFnYTGrXt6xL3o7LI
         0XEr6wWs39IRNlWDZVFJOwESxdnSyfscOk4ymbyWLT8neIjkA4RBsFbWI7JlUWHT1VNj
         +Ch4/U+0q33wAMuH1R+GdCvvQetVjj63EyV3ovbxWunYcypKQAicv5CKmNYNHG78DdUv
         fGOg==
X-Gm-Message-State: AOJu0Yz0RhqKYV+a4pEeHDrtZkYh/GwoizWM3kDC5S3b7SJy8EtUelQe
        x95amzq6Al4Tv/2f+VTvqw==
X-Google-Smtp-Source: AGHT+IFZh4DEDykHgtrtxCmEchLku/XR9qExlHVwrFIq+yLVUxiHjde4dUaA1N7szaN2O027lLdNxA==
X-Received: by 2002:a05:6830:43a6:b0:6c4:ca7b:5eef with SMTP id s38-20020a05683043a600b006c4ca7b5eefmr4446207otv.6.1698082854261;
        Mon, 23 Oct 2023 10:40:54 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6e0:8169:8cd7:6070:de02:c079])
        by smtp.gmail.com with ESMTPSA id bt33-20020a05683039e100b006c61c098d38sm1510542otb.21.2023.10.23.10.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:40:53 -0700 (PDT)
Received: (nullmailer pid 864636 invoked by uid 1000);
        Mon, 23 Oct 2023 17:40:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Romain Gantois <romain.gantois@bootlin.com>
Cc:     Luka Perkov <luka.perkov@sartura.hr>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>, davem@davemloft.net,
        thomas.petazzoni@bootlin.com, Paolo Abeni <pabeni@redhat.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Robert Marko <robert.marko@sartura.hr>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20231023155013.512999-2-romain.gantois@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-2-romain.gantois@bootlin.com>
Message-Id: <169808266457.861402.14537617078362005098.robh@kernel.org>
Subject: Re: [PATCH net-next 1/5] net: dt-bindings: Introduce the Qualcomm
 IPQESS Ethernet switch
Date:   Mon, 23 Oct 2023 12:40:49 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Oct 2023 17:50:08 +0200, Romain Gantois wrote:
> Add the DT binding for the IPQESS Ethernet switch subsystem, that
> integrates a modified QCA8K switch and an EDMA MAC controller. It inherits
> from a basic ethernet switch binding and adds three regmaps, a phandle and
> reset line for the PSGMII, a phandle to the MDIO bus, a clock, and 32
> interrupts.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  .../bindings/net/qcom,ipq4019-ess.yaml        | 152 ++++++++++++++++++
>  1 file changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml: psgmii-ethphy: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231023155013.512999-2-romain.gantois@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

