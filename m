Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BFE7CF8C0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345502AbjJSM2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjJSM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:28:34 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB16EBE;
        Thu, 19 Oct 2023 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KAdaUAiW/PLAxqjMWUUOBL8HfrZqlFhYhyfomShrMW8=; b=kCo5OFMFje7kyh0bUXC/x92Ir2
        b1s87iw/epDqvYES790GOuPO0fku4ZA8VcFd/q5/2PjYxHXU1Ai0byK90naR/9nbinCMPs+rxjLLL
        ohkIsXUyngQfbwQrdzHMeh1liHmWBCp2V8W4GeGrDBZJt2YqYqfQ1GtJwiZJD+OiUUqOGdXdUtwP5
        mlhpCvrfF9QB3BxEoh+VyI+bbRtfnrMZ1u4mM/gGwkzmJDw3qcMl99vQWqFQ+IWLvCbwMwEa5RYhq
        SYDSgu8Bszfm/TotWw2Qj9tlyeLsWXg6U5gaoF/LQrotd1OAervoSh54XryDf9JNrPpNGeT8+CLVp
        S+oLYSog==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57908)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qtS8Y-00072G-24;
        Thu, 19 Oct 2023 13:28:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qtS8Z-0000Rd-Tt; Thu, 19 Oct 2023 13:28:27 +0100
Date:   Thu, 19 Oct 2023 13:28:27 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
Message-ID: <ZTEg62nZtYXW2Uid@shell.armlinux.org.uk>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org>
 <169762516670.391804.7528295251386913602.robh@kernel.org>
 <20231019-repacking-scrunch-f2435c2fd7e8@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-repacking-scrunch-f2435c2fd7e8@spud>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 01:03:41PM +0100, Conor Dooley wrote:
> On Wed, Oct 18, 2023 at 05:32:48AM -0500, Rob Herring wrote:
> > 
> > On Wed, 18 Oct 2023 11:03:40 +0200, Linus Walleij wrote:
> > > Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> > > a DSA switch node need to have a ports or ethernet-ports
> > > subnode, and that is actually required, so add requirements
> > > using oneOf.
> > > 
> > > Suggested-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:7: [warning] wrong indentation: expected 8 but found 6 (indentation)
> > ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:7: [warning] wrong indentation: expected 8 but found 6 (indentation)
> > 
> > dtschema/dtc warnings/errors:
> > Traceback (most recent call last):
> >   File "/usr/local/bin/dt-doc-validate", line 64, in <module>
> >     ret |= check_doc(f)
> >            ^^^^^^^^^^^^
> >   File "/usr/local/bin/dt-doc-validate", line 32, in check_doc
> >     for error in sorted(dtsch.iter_errors(), key=lambda e: e.linecol):
> >                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/usr/local/lib/python3.11/dist-packages/dtschema/schema.py", line 125, in iter_errors
> >     self.annotate_error(scherr, meta_schema, scherr.schema_path)
> >   File "/usr/local/lib/python3.11/dist-packages/dtschema/schema.py", line 104, in annotate_error
> >     schema = schema[p]
> >              ~~~~~~^^^
> > KeyError: 'type'
> 
> Locally, on an older version of dt-schema, I see
> /stuff/linux-dt/Documentation/devicetree/bindings/net/dsa/dsa.yaml: $defs: 'oneOf' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
> 	hint: A json-schema keyword was found in $defs key.
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> /stuff/linux-dt/Documentation/devicetree/bindings/net/dsa/dsa.yaml: $defs:oneOf: [{'required': ['ports']}, {'required': ['ethernet-ports']}] is not of type 'object'
> 	hint: $defs entries must contain schemas
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> 
> On the latest version I see the error from the bot.
> 
> Doing 
> diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> index bd6948e4fd9e..25e5950d51ae 100644
> --- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> @@ -55,10 +55,10 @@ $defs:
>              $ref: dsa-port.yaml#
>              unevaluatedProperties: false
>  
> -  oneOf:
> -    - required:
> -      - ports
> -    - required:
> -      - ethernet-ports
> +oneOf:
> +  - required:
> +    - ports
> +  - required:
> +    - ethernet-ports
>  
>  ...
> 
> resolves both issues, but the older version of dt-schema definitely had
> better error reporting in this case!

And now I'm even more confused... your example in your other reply had
six spaces before "- ports" and "- ethernet-ports" but here you're
using four spaces.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
