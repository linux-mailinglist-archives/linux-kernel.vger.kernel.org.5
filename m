Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC797BA28C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjJEPk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJEPkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:40:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703D4545A8;
        Thu,  5 Oct 2023 07:55:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B660C433C8;
        Thu,  5 Oct 2023 14:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696517714;
        bh=HNIq3gj9XwCf0xsBOATUrSerdosaus7GV7T403QAhtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q7yZ9fIOszejj1ZSjqvX2yzqeAQL22a/p632pnplredVzk0zsxhbSKUlwuULgVwTM
         MHRB/4NAy0t5Cm6hKKkf/XK/jjJ102iq443DLpaGtGmCNl2DbR9IIncKsRduliJBnZ
         Apu2j/DOVEahsd6tW+WazbnbfGgKiFcElTEGNgE+Sjrp+SiXi5d6dQtL2zmvrIxs3B
         cmUqBAMC2sdhNGjsbKfmvyEg6NmfCfRoAQa/Zs67DQkMSfSevAMwv2VPD1+sm2xDaZ
         BlvUsYJQyChMUHJOx5h9QWSe+8gUDFmsWDhP+XT9qXD/WEeXUACP0tCafm/DvmsWKb
         1xqWul69SyLKA==
Date:   Thu, 5 Oct 2023 15:55:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?QW5k?= =?UTF-8?B?csOp?= Apitzsch <git@apitzsch.eu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device'
 error
Message-ID: <20231005155518.2fa53b49@jic23-huawei>
In-Reply-To: <20231003165535.000000b8@Huawei.com>
References: <20231001-ak_magnetometer-v1-1-09bf3b8798a3@apitzsch.eu>
        <20231002102745.0000540b@Huawei.com>
        <ZRqOn8tnJqvU22ex@smile.fi.intel.com>
        <20231003165535.000000b8@Huawei.com>
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

On Tue, 3 Oct 2023 16:55:35 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 2 Oct 2023 12:34:23 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>=20
> > On Mon, Oct 02, 2023 at 10:27:45AM +0100, Jonathan Cameron wrote: =20
> > > On Sun, 1 Oct 2023 18:09:56 +0200
> > > Andr=C3=A9 Apitzsch <git@apitzsch.eu> wrote:   =20
> >  =20
> > > > Fixes: 4f9ea93afde1 ("iio: magnetometer: ak8975: Convert enum->poin=
ter for data in the match tables")   =20
> >=20
> > ^^^ (1)
> >=20
> > ...
> >  =20
> > > So we need the spacer until someone converts this driver to use
> > > pointers instead for both of and ACPI tables.   =20
> >=20
> > Isn't it done by (1) which is in your tree?
> >  =20
> I can't remember what's in my tree :)
>=20
> Good point...
>=20
>=20
Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to poke at it.

Thanks,

Jonathan


