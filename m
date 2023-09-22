Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83AB7AB2E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjIVNqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjIVNqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:46:01 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C98492;
        Fri, 22 Sep 2023 06:45:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BC371BF20D;
        Fri, 22 Sep 2023 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695390352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3d45HSdjEBrGWXzT/hFE6ZoKYqY81rYCMtjLk2B/bLE=;
        b=biE04lp+7hE+NLdqozy2BgZPaAjb3vaTtdsBnKCNRXF0qN2XFtgDbT6n4cqLkcqbHptxLb
        oeMOmF7eHyF3aNQjMyD5QaHQjivx7ot6sdz0fFd0QcreP+88erVcjSDntCACDudD3RcyQH
        iK/3cWyQ7W7XAH8Riv34zdtaG/ZaF9U8gRbBkmmXP9wtu9Dpmv+8fBGDH2uHlFgTVuaf+D
        vUEEo2o7OwBll3KiAvIkjzGSfu3326QoSexo+bH5ppzRDvkVMmXLebD7B12+Z2XnIyyhNX
        ouCNBvOA0rABVPgSWhVwNkW32WK4XjYvnXpRZzPaNCdSCfw9y1M3ExfRT98Eow==
Date:   Fri, 22 Sep 2023 15:45:46 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Takashi Iwai <tiwai@suse.com>, Simon Horman <horms@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org, Paolo Abeni <pabeni@redhat.com>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shengjiu Wan g <shengjiu.wang@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>
Subject: Re: [PATCH v6 25/30] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
Message-ID: <20230922154546.4ca18b6f@bootlin.com>
In-Reply-To: <169538601225.2919383.2942072541503354871.robh@kernel.org>
References: <20230922075913.422435-1-herve.codina@bootlin.com>
        <20230922075913.422435-26-herve.codina@bootlin.com>
        <169538601225.2919383.2942072541503354871.robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 22 Sep 2023 07:33:32 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri, 22 Sep 2023 09:59:00 +0200, Herve Codina wrote:
> > The Lantiq PEF2256 is a framer and line interface component designed to
> > fulfill all required interfacing between an analog E1/T1/J1 line and the
> > digital PCM system highway/H.100 bus.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> >  .../bindings/net/lantiq,pef2256.yaml          | 214 ++++++++++++++++++
> >  1 file changed, 214 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
> >   
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/lantiq,pef2256.yaml: properties:lantiq,data-rate-bps: '$ref' should not be valid under {'const': '$ref'}
> 	hint: Standard unit suffix properties don't need a type $ref
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> 

The '-bps' suffix was added recently in
https://github.com/devicetree-org/dt-schema/
commit 033d0b1 ("Add '-bps' as a standard unit suffix for bits per second")

This commit is not yet present in any dt-schema release.

Should I update my patch (ie. removing $ref) right now even if this update will
make the last dt-schema release not happy ?

Regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
