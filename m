Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2890580DBE4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344820AbjLKUmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344828AbjLKUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:42:04 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F79D6;
        Mon, 11 Dec 2023 12:42:10 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1faecf57bedso3489012fac.3;
        Mon, 11 Dec 2023 12:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702327330; x=1702932130;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DFKQb/7yTTyqP+WONQNsPnQPZNy6QiIP6BOSliRozLg=;
        b=qbtDXrEYb0KufNqIcKtyyPgy/5LUEqF4teDklozOdAvC+aulDWhdghFjMpMDgp7GD9
         XHT9kJS7WrjBXCY4YjRHqkGz+3g5NcP0upSW+Pjhb21PHJ18Mp6sQ846f+kZ9OEGlXvq
         vVP93AVv9E7RIF9BQhSltQF7CeNSSMDGhJJzJq6DBX83ZpPKsip7V1Ero0jK0/AaYtaT
         kcdPxx+zxf+KNE4soUid2LQNNYl2uJKA/gcl7b5dMYd2uxTesMXPnDu4vCXRMeoJP+Wt
         JV/FBxiAGwygzN2OIOmpOwo5UgZEBKmWep53og/RilhPUPcfNSL8F+cgBCW89JduJ+uH
         Gqwg==
X-Gm-Message-State: AOJu0YwMP66+a5OH5Hlamp4Si8BKZJKAnH3wB5ud3fnIl0hwUnHVfKdj
        EfYw0sjVnU9o0i9m47LkVg==
X-Google-Smtp-Source: AGHT+IERzgL6eT6297cLEdH1ofw1Mjm0oIzNAtg0LSFt/ya3Ieo/FesvjdPlj5Ed946IaU5+wZT0RQ==
X-Received: by 2002:a05:6870:f155:b0:1fb:412:c2eb with SMTP id l21-20020a056870f15500b001fb0412c2ebmr6180027oac.50.1702327329989;
        Mon, 11 Dec 2023 12:42:09 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id gy16-20020a056870289000b001fb1bf9f5ddsm2656238oab.21.2023.12.11.12.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 12:42:09 -0800 (PST)
Received: (nullmailer pid 2870910 invoked by uid 1000);
        Mon, 11 Dec 2023 20:42:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20231211192318.16450-3-ansuelsmth@gmail.com>
References: <20231211192318.16450-1-ansuelsmth@gmail.com>
 <20231211192318.16450-3-ansuelsmth@gmail.com>
Message-Id: <170232732808.2870894.17994101779465776370.robh@kernel.org>
Subject: Re: [net-next RFC PATCH v2 3/4] dt-bindings: net: Document QCA808x
 PHYs
Date:   Mon, 11 Dec 2023 14:42:08 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Dec 2023 20:23:17 +0100, Christian Marangi wrote:
> Add Documentation for QCA808x PHYs for the additional LED configuration
> for this PHY.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Fix License warning from checkpatch
> - Drop redundant Description phrase
> - Improve commit tile
> - Drop special property (generalized)
> 
>  .../devicetree/bindings/net/qca,qca808x.yaml  | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/qca,qca808x.yaml: 'anyOf' conditional failed, one must be fixed:
	'properties' is a required property
	'patternProperties' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231211192318.16450-3-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

