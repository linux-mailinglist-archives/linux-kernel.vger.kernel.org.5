Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3647BBA17
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjJFOS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjJFOSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:18:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2213ECF;
        Fri,  6 Oct 2023 07:18:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A598C433C7;
        Fri,  6 Oct 2023 14:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696601933;
        bh=0ovsYW5Q2J+gOXo7/lzXREB9tQiG70t/j/9BXWf6eRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=II2Rif4FuMJmYzn4hxIc5qTWW/pw8gyQJitq6a8jIMnL1/lfAiEcYw3XwCuOTq9Wt
         N+Fyx1nvfbRFWVn6l0AKBuvjavXLqiaF+x9e1Ht7Tc35vryeJmSoREOS4OHP7550A8
         XxxabbtaWZYyb/IEK31pwB2zvLAAgVjTNfm8o/SxImzC+44D8T1EY1gQwNwr8HuaCK
         F8Gd5S7m6yu9wa6RiyjKzJqESLaXgj4Z6Px3+OJTnKg/STUvhC+L9+YBtbNEjLqD6h
         C8yT5e664q4CaonMxDsZJV+Le+64GTtNpD6BuaxPiA4QSydF+0XB8FVQr6jgSmvq1p
         HkMmbM6q3rMYQ==
Received: (nullmailer pid 3873922 invoked by uid 1000);
        Fri, 06 Oct 2023 14:18:51 -0000
Date:   Fri, 6 Oct 2023 09:18:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        conor+dt@kernel.org, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, broonie@kernel.org,
        sravanhome@gmail.com, jdelvare@suse.com
Subject: Re: [PATCH v2 2/3] regulator: dt-bindings: Add mps,mpq2286
 power-management IC
Message-ID: <20231006141851.GA3778656-robh@kernel.org>
References: <20230927033953.1503440-1-saravanan@linumiz.com>
 <20230927033953.1503440-3-saravanan@linumiz.com>
 <a1a50fb2-ddc6-4f85-9369-19b4c6c3bcd6@linaro.org>
 <358f7d3c-42d1-6405-0013-997deb974ce3@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <358f7d3c-42d1-6405-0013-997deb974ce3@linumiz.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 02:21:18PM +0530, Saravanan Sekar wrote:
> On 27/09/23 13:36, Krzysztof Kozlowski wrote:
> > On 27/09/2023 05:39, Saravanan Sekar wrote:
> > > Document mpq2286 power-management IC
> > > 
> > > Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> > > ---
> > >   .../bindings/regulator/mps,mpq2286.yaml       | 59 +++++++++++++++++++
> > >   1 file changed, 59 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
> > > new file mode 100644
> > > index 000000000000..594b929fe4b8
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
> > > @@ -0,0 +1,59 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/regulator/mps,mpq2286.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Monolithic Power System MPQ2286 PMIC
> > > +
> > > +maintainers:
> > > +  - Saravanan Sekar <saravanan@linumiz.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - mps,mpq2286
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  regulators:
> > > +    type: object
> > > +
> > > +    properties:
> > > +      buck0:
> > 
> > If you have just one buck, it should be "buck".
> > 
> 
> As replied in v1 review comments, other chipset has multiple regulator so
> buck0 used to keep the driver common

This patch needs to stand on its own with explanations/justifications. 
No one reviewing this remembers what was said in some reply. The 
explanation may be in the commit msg, under the '---', or in 
'description' here. Depends on the situation.

I don't see why the driver can't handle 'buck' and 'buckN'.

Rob
