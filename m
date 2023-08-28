Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9148378B5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjH1Qw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjH1Qvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEBF11D;
        Mon, 28 Aug 2023 09:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23A246114F;
        Mon, 28 Aug 2023 16:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B80C433C8;
        Mon, 28 Aug 2023 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693241512;
        bh=T0d80qXn16qoKb7jplMpbYYOjy7IIvigFzL4V4oJcPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eQ4y6VFwP1ySfyXQ5AL6hLcaeYF+VZCdxwqPZge4b4oBp8qg2JnF0C54sq8pl0L6q
         nq4Cpd2S25fqA4B8z8V3pW/1dVoVtNIGHeX0dqVRAjwAGdw/rXx2lmjggf7X9upB9C
         pphbwoUxV67wpZLj7ZTdPFuFDSx1p9x0o2h7TZxFzzS0A7tcPKj3K56GtSl8li8a92
         87iKaTNPUGVCgRV7c5kwE3KQUWEbfltzygbVSiuAf0FOHlRV+oUTgbeCAlY3bGfEIj
         ZTdL651myMRjGIl7wpT1wOe9Z7VbOi9EMSTRtNaV3TwTw9j4rgGEyu0WaBxRSYAvfn
         3JwdqdVbTaf/g==
Date:   Mon, 28 Aug 2023 17:52:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Dumitru Ceclan <mitrutzceclan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad717x: add AD717X driver
Message-ID: <20230828175206.7353ffba@jic23-huawei>
In-Reply-To: <34f5e2118a4714048231e6ee9a8f244248616bd0.camel@gmail.com>
References: <20230810093322.593259-1-mitrutzceclan@gmail.com>
        <20230810093322.593259-2-mitrutzceclan@gmail.com>
        <34f5e2118a4714048231e6ee9a8f244248616bd0.camel@gmail.com>
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

On Thu, 10 Aug 2023 13:57:02 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> Hi Dumitru,
>=20
> Thanks for taking care of this driver which is out of tree for a long tim=
e... Some
> comments below.
Hi.

A few follow ups...


> > +static int ad717x_setup(struct iio_dev *indio_dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ad717x_state *st =3D =
iio_priv(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int id;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 *buf;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* reset the serial interfac=
e */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buf =3D kcalloc(8, sizeof(*b=
uf), GFP_KERNEL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!buf)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memset(buf, 0xff, 8);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D spi_write(st->sd.spi=
, buf, 8);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(buf); =20
>=20
> Hmm, why allocating the buffer? I guess one could argue that we'll get DM=
A safe
> alignment but then maybe use some define instead of the magic 8.
>=20

Just use spi_write_then_read() without an read buffer as then it will use
magic bounce buffers for you within the spi subsystem.



> > +static struct spi_driver ad717x_driver =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.driver =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=C2=A0=3D "ad717x", =20
>=20
> I would keep the name as we have out of tree which is ad7173.c. I'm not s=
ure if
> there's any policy in here but I think typically you just name your drive=
r from the
> first supported device and then extend it from there. Since here you are =
just adding
> more than one device at once, it would be nice if you could keep the name=
 of the
> driver Lars originally developed...

In this case, indeed the one originally developed is a good choice.
Otherwise, pick a supported part.

Wild cards have bitten us far too many times as manufacturers love to
'use up' gaps in their ID space with parts that are either very different
or even worse look the same but have totally different interfaces...


>=20

