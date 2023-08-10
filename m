Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CBF7783F6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjHJXLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHJXLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:11:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98241BF7;
        Thu, 10 Aug 2023 16:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C5D164822;
        Thu, 10 Aug 2023 23:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87E3C433C7;
        Thu, 10 Aug 2023 23:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691709104;
        bh=t9u4okjPRplZKfcartS5jfdBSPagd8caxqSTAtJcsqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jU0LpY7aNkyLQsIa5pOpkn7jVmn1GDKiuMwBGB7KB4cZE1rH6RWIHWO82EkHIdZwc
         ShVcADxe8ypX14C2RjvwBl9uPrR+8ZJLYntuEyTxhusZiGgfIZtgs02iR+9cRAXyn+
         DbWGnqUhq8cIi2+uJfpM25WnfHWbIGZEd1xPNDBZMGDqzEeTAnTSe+hmrflQoz3NUl
         oVh44y5ifMMUj0V891TdfUS8VV++cRgzmxc0RqBzy0ylvm/8MlQYqoQN53TFiuwIyg
         RiPizeqZPbVTHzf/r2B34kNEn283q1aiVUXh2WzS9xPI1EKArLnPFGX6EdAEWxemck
         InEQGTkUjy5tQ==
Received: (nullmailer pid 1534590 invoked by uid 1000);
        Thu, 10 Aug 2023 23:11:42 -0000
Date:   Thu, 10 Aug 2023 17:11:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Conor Dooley <conor@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Jean Delvare <jdelvare@suse.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add MAX6639
Message-ID: <20230810231142.GA1506309-robh@kernel.org>
References: <20230803144401.1151065-1-Naresh.Solanki@9elements.com>
 <20230804-tamper-numbness-0117bb53a921@spud>
 <3f947ad6-eed6-59ff-e4e6-8b21d90eb803@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f947ad6-eed6-59ff-e4e6-8b21d90eb803@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 09:10:37AM -0700, Guenter Roeck wrote:
> On 8/4/23 08:48, Conor Dooley wrote:
> > On Thu, Aug 03, 2023 at 04:43:59PM +0200, Naresh Solanki wrote:
> > > From: Marcello Sylvester Bauer <sylv@sylv.io>
> > > 
> > > Add binding documentation for Maxim MAX6639 fan-speed controller.
> > > 
> > > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > ---
> > > Changes in V3:
> > > - Update title
> > > - Add pulses-per-revolution, supplies & interrupts
> > > Changes in V2:
> > > - Update subject
> > > - Drop blank lines
> > > ---
> > >   .../bindings/hwmon/maxim,max6639.yaml         | 60 +++++++++++++++++++
> > >   1 file changed, 60 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> > > new file mode 100644
> > > index 000000000000..b3292061ca58
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> > > @@ -0,0 +1,60 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Maxim MAX6639 Fan Controller
> > > +
> > > +maintainers:
> > > +  - Naresh Solanki <Naresh.Solanki@9elements.com>
> > > +
> > > +description: |
> > > +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
> > > +  fan-speed controller.  It monitors its own temperature and one external
> > > +  diode-connected transistor or the temperatures of two external diode-connected
> > > +  transistors, typically available in CPUs, FPGAs, or GPUs.
> > 
> > > +  fan-supply:
> > > +    description: Phandle to the regulator that provides power to the fan.
> > 
> > > +  pulses-per-revolution:
> > > +    description:
> > > +      Define the number of pulses per fan revolution for each tachometer
> > > +      input as an integer.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [1, 2, 3, 4]
> > > +    default: 2
> > 
> > Apologies if I am digging up old wounds here, since there was quite a
> > bit of back and forth on the last version, but these two newly added
> > properties look to be common with the "pwm-fan" and with
> > "adi,axi-fan-control". At what point should these live in a common
> > schema instead?
> > 
> > Otherwise, this looks okay to me, although I'll leave things to
> > Krzysztof since he had a lot to say about the previous version.
> > 
> 
> Rob has said that he won't accept any fan controller bindings without a generic
> schema. At the same time he has said that he expects properties such as the
> number of pulses per revolution to be attached to a 'fan' description, and he
> wants pwm related properties of fan controllers to be modeled as pwm controllers.
> And now we have a notion of a regulator providing power to the fan (which again
> would be the fan controller, at least in cases where the fan controller
> provides direct voltage to the fan). On top of that, this fan-supply property
> should presumably, again, be part of a fan description and not be part of the
> controller description. I don't think anyone knows how to make this all work
> (I for sure don't), so it is very unlikely we'll see a generic fan controller
> schema anytime soon.

I thought what was done earlier in this series was somewhat close. And 
there are some bindings that already look pretty close to what a common 
binding should. But it seems no one wants to worry about more than their 
1 device.

In case it's not clear, as-is, this binding is a NAK for me.

> Given that neither fan-supply nor pulses-per-revolution is implemented in the
> driver, and given that I am not aware of any fans which would have a value for
> pulses-per-revolution other than 2, my personal suggestion would be to add the
> chip to trivial devices and be done with it for the time being.

I'm fine with that too. Just keep kicking that can...

Rob
