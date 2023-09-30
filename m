Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E897B41EF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjI3QEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjI3QEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:04:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2027B7;
        Sat, 30 Sep 2023 09:04:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C38C433C7;
        Sat, 30 Sep 2023 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696089844;
        bh=uy+s2jrSaGO7rlv5j1HDB4iBkZhkxdyHSs6a8nZrnvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WlY+Qbc6QW4pVr2HwYC/satbNiuDKVSmaXTfyXcHh9hJDKsYgRa24Be10WA89AVTp
         gwW84YfhFLhUAQDfS3F8umAhIdR0fvLQqPPsZYJNlPWILqV/U8z9R+k3IqMqHwaUMH
         CCCsz61/r8eVvD1h1U8x/6/KkxDZ4fqpthm04c345w1jmIYlj9zFc7kFx+M4PIYQOX
         GvBi9/Epq4SsT+XFYK25bq/IgT+A0yzMVhqE+Vjvo7GI8WKkx9NdOn4bnZPfDcpinb
         9o/NoshcW0Jc5whsKb11PoDrJXUiYw6YTp3LCFolELgh42gREsSspoLcaYXTWz/RPw
         BwHtl3phKZf4g==
Date:   Sat, 30 Sep 2023 17:04:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
Message-ID: <20230930170404.515395b1@jic23-huawei>
In-Reply-To: <f8735a6d81d485eb8e822e4fd55a00269ae688c2.camel@gmail.com>
References: <20230917211143.7094-1-fr0st61te@gmail.com>
        <20230917211143.7094-2-fr0st61te@gmail.com>
        <20230924135359.6404a867@jic23-huawei>
        <f8735a6d81d485eb8e822e4fd55a00269ae688c2.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 19:48:39 +0300
Ivan Mikhaylov <fr0st61te@gmail.com> wrote:

> On Sun, 2023-09-24 at 13:53 +0100, Jonathan Cameron wrote:
> > On Mon, 18 Sep 2023 00:11:42 +0300
> > Ivan Mikhaylov <fr0st61te@gmail.com> wrote:
> >  =20
> > > The i2c driver with Rsense option for current monitoring.
> > >=20
> > > Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com> =20
> >=20
> > Hi Ivan,
> >=20
> > Welcome to IIO!
> >=20
> > Looks good, but there are a few things I'd add to make this describe
> > the device
> > a little more fully and flexibly.=C2=A0 Ideally we want a binding to fu=
lly
> > describe
> > a device, even if the particular driver for Linux doesn't use all the
> > features.
> > Some are easy though such as enabling regulators (that are probably
> > turned on
> > already on your board)
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > > ---
> > > =C2=A0.../bindings/iio/adc/maxim,max34408.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 63
> > > +++++++++++++++++++
> > > =C2=A01 file changed, 63 insertions(+)
> > > =C2=A0create mode 100644
> > > Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > new file mode 100644
> > > index 000000000000..ae7c6ddb13d8
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > @@ -0,0 +1,63 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Two- and four-channel current monitors with overcurrent
> > > control.
> > > +
> > > +maintainers:
> > > +=C2=A0 - Ivan Mikhaylov <fr0st61te@gmail.com>
> > > +
> > > +description: |
> > > +=C2=A0 The MAX34408/MAX34409 are two- and four-channel current monit=
ors
> > > that are
> > > +=C2=A0 configured and monitored with a standard I2C/SMBus serial
> > > interface. Each
> > > +=C2=A0 unidirectional current sensor offers precision high-side
> > > operation with a
> > > +=C2=A0 low full-scale sense voltage. The devices automatically seque=
nce
> > > through
> > > +=C2=A0 two or four channels and collect the current-sense samples and
> > > average them
> > > +=C2=A0 to reduce the effect of impulse noise. The raw ADC samples are
> > > compared to
> > > +=C2=A0 user-programmable digital thresholds to indicate overcurrent
> > > conditions.
> > > +=C2=A0 Overcurrent conditions trigger a hardware output to provide an
> > > immediate
> > > +=C2=A0 indication to shut down any necessary external circuitry.
> > > +
> > > +=C2=A0 Specifications about the devices can be found at:
> > > +=C2=A0
> > > https://www.analog.com/media/en/technical-documentation/data-sheets/M=
AX34408-MAX34409.pdf
> > > +
> > > +properties:
> > > +=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0 enum:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - maxim,max34408
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - maxim,max34409
> > > +
> > > +=C2=A0 reg:
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 interrupts:
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 maxim,rsense-val-micro-ohms: =20
> > From the datasheet you link, it looks like this could be different
> > for
> > the inputs? =20
>=20
> Hi Jonathan, "maxim,input1-rsense-val-micro-ohms", "maxim,input2-
> rsense-val-micro-ohms" and etc would be better?

Sorry, missed this during the week (too many emails at work!)

Anyhow, I'd have suggested an array, but a better suggestion was
made anyway in reply to your v2.
