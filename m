Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F64080F447
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjLLRSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjLLRSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:18:20 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BEDB7;
        Tue, 12 Dec 2023 09:18:26 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-590711b416fso3370999eaf.2;
        Tue, 12 Dec 2023 09:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401505; x=1703006305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48KM5C81ULvMHSLTn8udFz6tGE21YI180mYUHTStYAM=;
        b=qa7mmL3V4rxM4u60yK20idQQaOQ8uI3cJclUzvDcDWcCBfjJxhJaNdHz3kcTz7n+45
         Ez+4REnBOdq+rDSpgchhILslQcwelwYyhoyfzPPTf0ucjjSGgfFVQvUvZECbn67CBPOG
         DHKXNBMcRMv6LXuT5+DM+wpHlFR0M1R8YSfzZVv8dtLbw4FgPQVHI0ngtczgzCtW+XwY
         zy3CJEUOL0a79ke9tC334tlMubUy+hQ7o3+5UmEQuGL/erd/ScXSXQb0e70wBhlqugAQ
         J3zlhp3pOR3HGu3FkiD2YczgNCBZ0Rz8ljb/1kMZUguCjvRENc/nkwIWoHR7h+nVWPaY
         2V0Q==
X-Gm-Message-State: AOJu0YzVosuVo5e8vvC1vETui3t3VVgh0BydtF7g/BhiLPoR/Gw+cjfq
        /bD57nUlkPGNjB4UzDQGaQ==
X-Google-Smtp-Source: AGHT+IHD8gCXBNfy+Vh8iNigMzwrmwHoW1c/3coGS1gxubPbH4uqznefr+QqzOtaLxsW1jHytFDPFg==
X-Received: by 2002:a05:6820:162c:b0:58a:128:8ff0 with SMTP id bb44-20020a056820162c00b0058a01288ff0mr5873923oob.5.1702401505245;
        Tue, 12 Dec 2023 09:18:25 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l26-20020a4a855a000000b0058d1f2e1c8csm2549264ooh.40.2023.12.12.09.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:18:24 -0800 (PST)
Received: (nullmailer pid 2286788 invoked by uid 1000);
        Tue, 12 Dec 2023 17:18:22 -0000
Date:   Tue, 12 Dec 2023 11:18:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [net-next RFC PATCH v2 3/4] dt-bindings: net: Document QCA808x
 PHYs
Message-ID: <20231212171822.GA2209593-robh@kernel.org>
References: <20231211192318.16450-1-ansuelsmth@gmail.com>
 <20231211192318.16450-3-ansuelsmth@gmail.com>
 <170232732808.2870894.17994101779465776370.robh@kernel.org>
 <657775d5.5d0a0220.20552.2a2d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657775d5.5d0a0220.20552.2a2d@mx.google.com>
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

On Mon, Dec 11, 2023 at 09:49:22PM +0100, Christian Marangi wrote:
> On Mon, Dec 11, 2023 at 02:42:08PM -0600, Rob Herring wrote:
> > 
> > On Mon, 11 Dec 2023 20:23:17 +0100, Christian Marangi wrote:
> > > Add Documentation for QCA808x PHYs for the additional LED configuration
> > > for this PHY.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > > Changes v2:
> > > - Fix License warning from checkpatch
> > > - Drop redundant Description phrase
> > > - Improve commit tile
> > > - Drop special property (generalized)
> > > 
> > >  .../devicetree/bindings/net/qca,qca808x.yaml  | 58 +++++++++++++++++++
> > >  1 file changed, 58 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/qca,qca808x.yaml: 'anyOf' conditional failed, one must be fixed:
> > 	'properties' is a required property
> > 	'patternProperties' is a required property
> > 	hint: Metaschema for devicetree binding documentation
> > 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231211192318.16450-3-ansuelsmth@gmail.com
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> >
> 
> Erm sorry for the bot error... But How to handle this? 

You should define what the compatible must be under properties and drop 
'select' (it will get generated). 'contains' in the select is generally 
not sufficient constraint though since ethernet-phy.yaml happens to 
limit compatible to 1 entry, it is in this case.

Rob
