Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5C77E77D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbjHPRVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345185AbjHPRVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:21:05 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44E72701;
        Wed, 16 Aug 2023 10:21:01 -0700 (PDT)
Received: from p5dcc3794.dip0.t-ipconnect.de ([93.204.55.148] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qWKCR-002hN9-Gx; Wed, 16 Aug 2023 19:20:51 +0200
Date:   Wed, 16 Aug 2023 19:20:49 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Conor Dooley <conor@kernel.org>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, rydberg@bitmath.org,
        u.kleine-koenig@pengutronix.de, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, heiko@sntech.de
Subject: Re: [PATCH 1/4] dt-bindings: touchscreen: convert neonode,zforce to
 json-schema
Message-ID: <20230816192049.630fbf6c@aktux>
In-Reply-To: <20230816-customary-service-8d9c5e5dbf1b@spud>
References: <20230815182948.212575-1-andreas@kemnade.info>
        <20230815182948.212575-2-andreas@kemnade.info>
        <20230816-customary-service-8d9c5e5dbf1b@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 15:52:16 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Aug 15, 2023 at 08:29:45PM +0200, Andreas Kemnade wrote:
> > Convert Neonode infrared touchscreen controller binding to DT schema.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  .../input/touchscreen/neonode,zforce.yaml     | 67 +++++++++++++++++++
> >  .../bindings/input/touchscreen/zforce_ts.txt  | 34 ----------
> >  2 files changed, 67 insertions(+), 34 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml b/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
> > new file mode 100644
> > index 000000000000..1c45adb2407a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/touchscreen/neonode,zforce.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Neonode infrared touchscreen controller
> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko.stuebner@bqreaders.com>  
> 
> It;d be good to CC the person you're volunteering! I've done so.
> 
well, apparently my get_maintainer.pl | confirm_and_add_addresses | git send-email
script did not run in the kernel checkout I applied the patch to, so it did
not catch that address. Sorry. BTW: What is common practice for the maintainer address
in the binding in conversions? Here I looked at the commits of the plaintext binding.

Regards,
Andreas
