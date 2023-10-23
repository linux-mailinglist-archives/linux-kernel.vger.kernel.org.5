Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0C67D4072
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjJWTt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJWTt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:49:58 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201FAD68;
        Mon, 23 Oct 2023 12:49:56 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1ea05b3f228so2555147fac.1;
        Mon, 23 Oct 2023 12:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090595; x=1698695395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOml9Fs4hOzKuKFOJI/FHMdAz6TOVK13fas10eq0Vz0=;
        b=B765MXa7fctubcaEE21VzEXnHcB5m5TUsKOaib5KMu+46pMRpJ8E4FAUlK5UZkUea/
         igEe7wnLJYmY8Pt/srekMvowJmJN2zqrlYJcsqNhhrYTsYlw7HDuo/R/E0zEuND0ijX3
         ZXLrwl4pLV7BGZZk+Sdzit/Zijf0oxFCkcUdu2MIL4rHbal3mIj9yDBOEytAFrxP6n++
         fMwCJfhqPCzGIYG4gDniTPwyF8LyWabxES5bxBrHJD92d7j2jPFC08Tempaqe+lQh9RC
         jyX2FV+nONJU3CWRV3iTHSAoMuiU4T/GtPwfpGRKSRlUGkWU7o/LzBUzDuBFUVY7A1Hi
         rN0w==
X-Gm-Message-State: AOJu0Yy39mu1aNgX2KOKGH17mb9+WwsJ0iJ8t1LxTLzrQyzkGQc3Bzf0
        Btqv3Lkw6usO2CV7uKxVCVAq1rrHUw==
X-Google-Smtp-Source: AGHT+IEJfKNoziu5KT4LDPxSPtLQoQrQ8kjptNN1dvn6JmcValfIIekDzmvGdctgxlZDQz0WflaiCA==
X-Received: by 2002:a05:6870:610b:b0:1e9:8b78:899c with SMTP id s11-20020a056870610b00b001e98b78899cmr12307489oae.55.1698090595284;
        Mon, 23 Oct 2023 12:49:55 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dy20-20020a056870c79400b001e1754b9fc1sm1772111oab.24.2023.10.23.12.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:49:54 -0700 (PDT)
Received: (nullmailer pid 1152555 invoked by uid 1000);
        Mon, 23 Oct 2023 19:49:53 -0000
Date:   Mon, 23 Oct 2023 14:49:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     netdev@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 2/7] dt-bindings: net: mvusb: Fix up DSA
 example
Message-ID: <169809057969.1149966.2296744128010096950.robh@kernel.org>
References: <20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org>
 <20231023-marvell-88e6152-wan-led-v5-2-0e82952015a7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-marvell-88e6152-wan-led-v5-2-0e82952015a7@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 09:18:53 +0200, Linus Walleij wrote:
> When adding a proper schema for the Marvell mx88e6xxx switch,
> the scripts start complaining about this embedded example:
> 
>   dtschema/dtc warnings/errors:
>   net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells'
>   is a required property
>   from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
>   net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells'
>   is a required property
>   from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> 
> Fix this up by extending the example with those properties in
> the ports node.
> 
> While we are at it, rename "ports" to "ethernet-ports" and rename
> "switch" to "ethernet-switch" as this is recommended practice.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/marvell,mvusb.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

