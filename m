Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031097DBB00
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjJ3Nj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3Nj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:39:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10797
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:39:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF366C433C8;
        Mon, 30 Oct 2023 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698673164;
        bh=7172ARlU093nkC66v/TSAxNqYCux9x9VPI6S/wkzmys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lzt2ZsLlDpz1OEOUgm5OhyaiQI5XcG7IK+uEdU4r7vy8/gi/eZDPzCuTC6uF+n2eu
         sMKznWxK+d17ECoihTOa0oX3+s8kdrpSXqWf5L4lNatY5arX9c6JDXlgUO2ObTLqxw
         X1B7RO9WnsNlAmUufbFx+UQ7MpYI46xw0GmUEnhkiY0NoWEz7wHdGTM70mu5zT5FAd
         jL/vOn3xOnB1yt2IgzyArGs7UJR6SwT47MF7aWA3Zwf8193xkkSKRXO2pVEVhyn5gj
         fsg/MhR601rxYuF6wWIyFp52PXAYSV7ovGmrWESMprENdkt+TQc/R0r5oL3Zm5A4Kj
         b5U1iRNTwqpHA==
Date:   Mon, 30 Oct 2023 14:39:21 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/8] drm/loongson: Introduce a drm bridge driver for
 it66121 HDMI transmitter
Message-ID: <e4ozgwe7g5s3bioywxqcetuqwxk6byvz2lr3swlgy7wutxcxkp@obvvszcgz2qw>
References: <20231029194607.379459-1-suijingfeng@loongson.cn>
 <20231029194607.379459-3-suijingfeng@loongson.cn>
 <CAA8EJprjQXcTgxnC1POaBjVBzyVBvKpmKyJcCR5ExRUhVxtYoQ@mail.gmail.com>
 <3ccb9600-6990-4ec7-81de-0d7b4e1294eb@loongson.cn>
 <CAA8EJpqCe2j3GyeutnwTB0bkGXGk0az9-w3sPHLFwMVgAS=e7g@mail.gmail.com>
 <df176548-0001-4df4-b556-6227b776cd18@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2cbip6tmp5j2oowq"
Content-Disposition: inline
In-Reply-To: <df176548-0001-4df4-b556-6227b776cd18@loongson.cn>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2cbip6tmp5j2oowq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 09:25:50PM +0800, Sui Jingfeng wrote:
> I think my approach provide a solution, while still keep the bridges driv=
ers
> to a modular at the same time. Despite simple, it indeed solve the proble=
m.
> It simple because of explicit control of the loading order by myself, not=
 by
> rely on the framework or something else (say component)
>=20
> It is not totally duplicating, I have rewrite part of them. You can compa=
re
> to see what I'm changed. It is just that it66162 was upstream-ed earlier =
than
> our solution. But I also have write display drivers for lt8618 and lt8619
> completely by myself.
>
> Even though our local drm bridges driver will not be able to enjoy the up=
dates.
> We will accept such a results(or pain). I can maintain our local drm brid=
ges
> drivers by myself. Sorry, on this technique point, we will not follow you=
r idea.
> I'm sure that my approach is toward to right direction for our device at =
now.
> If someone invent a better solution to handle this problem, which make the
> various drm bridges drivers usable out of box, then I will follow and coo=
perate
> to test.

As far as I'm concerned, the two options are either you reuse the
already existing driver or this series isn't merged.

Ignoring what issue we raised and still merging your patch isn't on the
table, sorry.

Maxime

--2cbip6tmp5j2oowq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZT+yCQAKCRDj7w1vZxhR
xWvFAP9k53SCPnaxsg9Uc5iHT3bjHKTMhbl+/6pokYTmjiB9WgD9FNBO2ztxI2Ah
lg/MJmIFuKoV4egJ7R5B5n987tYHZQk=
=hZBP
-----END PGP SIGNATURE-----

--2cbip6tmp5j2oowq--
