Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9C37D9705
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbjJ0Lyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345780AbjJ0Lyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:54:43 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC50ED7;
        Fri, 27 Oct 2023 04:54:40 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1e9c42fc0c9so1022559fac.1;
        Fri, 27 Oct 2023 04:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698407680; x=1699012480;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9b+/9ZwUdROxnR+oS+/WwpQi1QFxbE22Ia4rZevwgMo=;
        b=MvRl46K3vsPnSAGZJr1TI1s8IsqM3w+78N9VT8wRDNl4Ow/hcFe3QBUcFgLV8lmavF
         M9VqTx73QeNBksPwvPrsYgeat+F/HFe1r7T00i2dEN8KW2dYCzQ+RIjB3dX4QFEXpacc
         rW7HyK+8zsSEmSDbjb/JIr1UaIlTi+Ico/zyryG2oU6NabtCEvjOnsS8TH3yzIM/BpGf
         f92D8zZuw/mIH0OwO3sAO59kZPeeB+vb8VlZiLu9/HSqB7RsGUMCy0kZxUR2mKY5+SuF
         FMqI3zlvVJtFTzF6/PhCaZfiOajJ8honhGDctzYWd/wZ0gTKWLe0NKDzlqAJ0tRxWkNp
         T7OQ==
X-Gm-Message-State: AOJu0Yx0Nx7yVUMWVs2uH5OAmc98TVF4E5ogbc+W+Sfgm3dKw3v2vYjM
        YMNwu/X8+QY0+mA5DSxOeg==
X-Google-Smtp-Source: AGHT+IHxDsoKekl8Yvqf0gShEW9817qFAuqyXO1pz/hZt/mb8dMArGiXOTmukS2xWKDp/y2/VxMElA==
X-Received: by 2002:a05:6870:9e98:b0:1e9:b29b:b145 with SMTP id pu24-20020a0568709e9800b001e9b29bb145mr3170664oab.7.1698407679875;
        Fri, 27 Oct 2023 04:54:39 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ef11-20020a0568701a8b00b001c5a3e31474sm267686oab.45.2023.10.27.04.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 04:54:38 -0700 (PDT)
Received: (nullmailer pid 2176039 invoked by uid 1000);
        Fri, 27 Oct 2023 11:54:37 -0000
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
 <e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com>
Message-Id: <169839099385.1526712.3835943870318448924.robh@kernel.org>
Subject: Re: [RFC v5 5/5] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Date:   Fri, 27 Oct 2023 06:54:37 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Oct 2023 06:28:11 +0000, Oleksii Moisieiev wrote:
> Add new SCMI v3.2 pinctrl protocol bindings definitions and example.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> 
> ---
> Changes v3 -> v4
>   - reworked protocol@19 format
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/firmware/arm,scmi.yaml:244:15: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/firmware/arm,scmi.yaml:258:19: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/firmware/arm,scmi.yaml:259:19: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

