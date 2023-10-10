Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C517C0172
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjJJQTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjJJQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:19:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDDE93;
        Tue, 10 Oct 2023 09:19:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDF5C433C8;
        Tue, 10 Oct 2023 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696954742;
        bh=ag41vErJLcdKpWvik5kJhsbnkB03toTtYunAk74GnXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dx7YaSUcnpJ6i31sJjGmTurhcph5FdWf+D6PUKBdn7Kpq4plRrckNxcBAOeYqXbPf
         MiQKYc0310YaucJacgIq6+fgIQArdHKfLY7kpbGRk864Cakn8zYBRC/5YY14vfJGEj
         K5CHmkZKhkPOxzHHtEOdZRJORREJKlMOGYMr+sYIqxlhouiZzxu33loyGXcRu8C45d
         h0CQRL+GQuon+oqhK5MCfkIVyaanl7ni3gAdJ1QvqQTPXM0BOJ4wYCBBS/8ZGWlIyD
         pVib/siMUCWjRsQaW/eJXLbD9fDeXoLhGN2BCpKp85b+6PtaVW0Gdh/TRxkoObx5N8
         VCVOy5R8KsKEw==
Received: (nullmailer pid 1003012 invoked by uid 1000);
        Tue, 10 Oct 2023 16:19:00 -0000
Date:   Tue, 10 Oct 2023 11:19:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Avago APDS9306
Message-ID: <20231010161900.GA999361-robh@kernel.org>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
 <20231008154857.24162-2-subhajit.ghosh@tweaklogic.com>
 <2c6ff28f-9031-beb2-f8d0-e7f12b0a07b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6ff28f-9031-beb2-f8d0-e7f12b0a07b4@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:52:28AM +0300, Matti Vaittinen wrote:
> On 10/8/23 18:48, Subhajit Ghosh wrote:
> > Add devicetree bindings for Avago APDS9306 Ambient Light Sensor.
> > 
> > Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> > ---
> >   .../bindings/iio/light/avago,apds9306.yaml    | 49 +++++++++++++++++++
> >   1 file changed, 49 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
> > new file mode 100644
> > index 000000000000..e8bb897782fc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/light/avago,apds9306.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Avago APDS9306 Ambient Light Sensor
> > +
> > +maintainers:
> > +  - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> > +
> > +description:
> > +  Datasheet at https://docs.broadcom.com/doc/AV02-4755EN
> > +
> > +properties:
> > +  compatible:
> > +    const: avago,apds9306
> 
> I see the driver supports two different variants of this IC, differentiated
> by the part-ID register. Variants are named as apds9306 and apds9306-065. I
> wonder if we could/should have different compatibles for them?

If 1 compatible is sufficient to know how to power on both devices and 
read the part-ID register, then no need for different compatibles.

Rob
