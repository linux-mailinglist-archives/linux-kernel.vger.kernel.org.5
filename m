Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8177D6F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344897AbjJYOPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjJYOPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:15:14 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 07:15:08 PDT
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF859F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:15:08 -0700 (PDT)
Date:   Wed, 25 Oct 2023 16:07:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698242853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tuu/xKNEUp/rVDyrYJ845iJbRdmfWFFfKxYqRchBIq0=;
        b=Uvj77L7n0FVroa8NBfscxvh0MGR2XFY59+eXSR8HvoBB5koZtT753qnqt2/bckbVU9cj1c
        TNUnGoPv11idbQP+xJkRdOA+ZDsfZ/0HbpzN+Oy0xRfdQutwbUSzGbeyLZps/zuI+F4+WY
        qZbW3Zk7IUWpipvLDVIe6JBGPVLGzfc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Conor Dooley <conor@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: hwmon: add ti,ina238
Message-ID: <qoxgyho5twbm4jopfveaf5ee3z4tkyb2z5f2vsyrpglffegmxf@v2z5ckcaa5jc>
References: <20231025-ina237-v1-0-a0196119720c@linux.dev>
 <20231025-ina237-v1-2-a0196119720c@linux.dev>
 <20231025-hut-omnivore-f4b44a7b928d@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-hut-omnivore-f4b44a7b928d@spud>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 03:00:01PM +0100, Conor Dooley wrote:
> On Wed, Oct 25, 2023 at 10:34:12AM +0000, Richard Leitner wrote:
> > The ina238 driver is available since 2021 but lacks a dt-bindings file.
> > Therefore add the missing file now.
> 
> Seemingly it is documented in Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml

Thanks for the feedback. True. So is it fine if it's left there or
should it be removed from ti,ina2xxx.yml as this is a separate driver
with different properties?

> 
> Cheers,
> Conor.
> 
> > 
> > Mention Jean Delvare and Guenter Roeck as maintainers as reported by the
> > get_maintainer.pl script.
> > 
> > Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
> > ---
> >  .../devicetree/bindings/hwmon/ti,ina238.yaml       | 46 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 47 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml
> > new file mode 100644
> > index 000000000000..aba89e5f34b3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/hwmon/ti,ina238.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments INA238 power/voltage monitors
> > +
> > +maintainers:
> > +  - Jean Delvare <jdelvare@suse.com>
> > +  - Guenter Roeck <linux@roeck-us.net>
> > +
> > +description: |
> > +  The INA238 is an ultra-precise digital power monitor with a
> > +  16-bit delta-sigma ADC specifically designed for current-sensing
> > +  applications.
> > +
> > +  Datasheets:
> > +    https://www.ti.com/lit/ds/symlink/ina238.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,ina238
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        power-sensor@40 {
> > +            compatible = "ti,ina238";
> > +            reg = <0x40>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 28f91c8a2e1c..13858bd6a3d4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10271,6 +10271,7 @@ INA238 HARDWARE MONITOR DRIVER
> >  M:	Guenter Roeck <linux@roeck-us.net>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > +F:	Documentation/devicetree/bindings/hwmon/ti,ina238.yaml
> >  F:	drivers/hwmon/ina238.c
> >  
> >  INDEX OF FURTHER KERNEL DOCUMENTATION
> > 
> > -- 
> > 2.40.1
> > 


