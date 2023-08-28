Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555B278B23A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjH1NsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjH1NsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA04BE;
        Mon, 28 Aug 2023 06:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2C5C60AEB;
        Mon, 28 Aug 2023 13:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C04C433C8;
        Mon, 28 Aug 2023 13:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693230481;
        bh=GVS9K39HjDgBoCnUBCmug1eBB4QIhqQdI0YUhrZVE/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yl3PPRdTAjP1ANgSzYj7dO1c0/sYYOp9Qsij75FHVbZPpVHfE/A35tcHw0dSTztml
         +TeTn1ltB7Sz46QLuJAzLDat2yBbGK/z+Pa8wJTLPSrudzSadilwmhrcwR2VhuvNP6
         AeIzK5zOvPuVI3aPHtqj0lhNooW1T5rnfdvlQdQge9sK5+mV+cdnCYuAB4l4QhRN6s
         p7il3FEaZBW/rVhhMR96acBbHIq3+Tgind1uFQt38mfAJVGDMQq2lMZ0Srxmc4eHHM
         wjRz7w/XBeofdoL0HqIgFox7x7UWAqKf1rkFnWS5E95pkzEscKrc2Y5P8wB7Kctvab
         fQg2Nc9zMJBXA==
Date:   Mon, 28 Aug 2023 14:48:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Marius.Cristea@microchip.com>
Cc:     <devicetree@vger.kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: adding support for MCP3564 ADC
Message-ID: <20230828144820.5552aa0a@jic23-huawei>
In-Reply-To: <1c0f578669737e7f27a8ff9e0416b6c96eb917f2.camel@microchip.com>
References: <20230804142820.89593-1-marius.cristea@microchip.com>
        <20230804142820.89593-3-marius.cristea@microchip.com>
        <20230805185900.2441a20e@jic23-huawei>
        <1c0f578669737e7f27a8ff9e0416b6c96eb917f2.camel@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 16:29:26 +0000
<Marius.Cristea@microchip.com> wrote:

> Hi Jonathan,
>=20
> >  =20
> > > @@ -0,0 +1,53 @@
> > > +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > /sys/bus/iio/devices/iio:deviceX/boost_current
> > > +KernelVersion:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.4
> > > +Contact:=C2=A0=C2=A0=C2=A0=C2=A0 linux-iio@vger.kernel.org
> > > +Description:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 This attribute is used to set the biasing circuit of
> > > the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Delta-Sigma modulator. The different BOOST settings
> > > are applied
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 to the entire modulator circuit, including the
> > > voltage reference
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 buffers. =20
> >=20
> > Units?=C2=A0 Should be=C2=A0 mA given that is what we use for other cur=
rent
> > attributes
> > in IIO.
> >  =20
>=20
> This should have no units because is a "gain" for the bias current. I
> think it will be better to change the name of the attribute to
> "boost_current_gain".

That's sounds reasonable to me as well.


>=20
>=20
> > This one may cause us problems with generality of the description if
> > we reuse
> > if for other devices (and hence move it to the more general files),
> > but we
> > can figure this out at the time.
> >  =20
> > >  =20
>=20
> Thanks and Best Regards,
> Marius
>=20

