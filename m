Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD27803771
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbjLDOtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjLDOta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:49:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0CFB3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:49:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD35C433C7;
        Mon,  4 Dec 2023 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701701376;
        bh=+rfhQvthjBio9vKPuOuZeZLKHbgV1eAS2Q4KP5aiGdw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mP1NKR8WcwA+hcZQ6uKxxCQEnsh3wuXEAjUr52iqagkAxstbdi8MnYIviiDX0Y+tN
         FAPnWwLPDVJE6/0x0dRz9DUEl35GqLq3/BvMWTQVFeh5qzzKYvLbxBF1R3JMlUe3PU
         2nsB5bDfcVu21DcHS+eV/VKlsW8o0uV1iBc/aGRlav7o8NTlluBw0MSsCZ74fa77KM
         jKEZtDLPH05I7H0Ftn58M5hS95djYVZyJDt2jHdD9ys8e/JZKNf9iruGYWzWGKItg2
         UwGjVHVbq8TkFWccMc1HBnxtFvIjF8+yWhL4VHfjn7w2d/XNpAv+2Uq6QSFtYlBOZZ
         AQ5/hYhWUpxiQ==
Date:   Mon, 4 Dec 2023 14:49:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 00/12] iio: add new backend framework
Message-ID: <20231204144925.4fe9922f@jic23-huawei>
In-Reply-To: <CAMknhBEg+cFrm9kQh1G+8nxGPCFsBaca3rnLEnXZ1h=XDS1aeQ@mail.gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
        <CAMknhBH0pF_+z_JqWGscELBmAEDyxLAtgQ-j3=6P2MeFXnzhWQ@mail.gmail.com>
        <CAMknhBEcEJ01nO0p5_vy4jVBVTL_rhEk+pvBpXdMtaDurc-05A@mail.gmail.com>
        <369a72dd34c0bc457620b88594a975d96aa85a22.camel@gmail.com>
        <CAMknhBEg+cFrm9kQh1G+8nxGPCFsBaca3rnLEnXZ1h=XDS1aeQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2023 10:16:52 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Sat, Dec 2, 2023 at 3:37=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> >
> > On Fri, 2023-12-01 at 21:53 -0600, David Lechner wrote: =20
> > > On Thu, Nov 30, 2023 at 5:54=E2=80=AFPM David Lechner <dlechner@bayli=
bre.com> wrote: =20
> > > >
> > > > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > > > <devnull+nuno.sa.analog.com@kernel.org> wrote: =20
> > > > >
> > > > > Hi all,
> > > > >
> > > > > This is a Framework to handle complex IIO aggregate devices.
> > > > >
> > > > > The typical architecture is to have one device as the frontend de=
vice which
> > > > > can be "linked" against one or multiple backend devices. All the =
IIO and
> > > > > userspace interface is expected to be registers/managed by the fr=
ontend
> > > > > device which will callback into the backends when needed (to get/=
set
> > > > > some configuration that it does not directly control).
> > > > >
> > > > > The basic framework interface is pretty simple:
> > > > >  - Backends should register themselves with @devm_iio_backend_reg=
ister()
> > > > >  - Frontend devices should get backends with @devm_iio_backend_ge=
t()
> > > > >
> > > > > (typical provider - consumer stuff)
> > > > > =20
> > > >
> > > > The "typical provider - consumer stuff" seems pretty straight forwa=
rd
> > > > for finding and connecting two different devices, but the definition
> > > > of what is a frontend and what is a backend seems a bit nebulous. It
> > > > would be nice to seem some example devicetree to be able to get a
> > > > better picture of how this will be used in practices (links to the =
the
> > > > hardware docs for those examples would be nice too).
> > > > =20
> > >
> > > Fulfilling my own request here...
> > >
> > > Since AD9467 is being use as the example first user of the IIO offloa=
d framework
> > > I did a deep dive into how it is actually being used. It looks like t=
his:
> > > =20
> >
> > This is not an offload framework... I think somehow you're connecting t=
his to the
> > spi_engine offload and these are two completely different things. Maybe=
 they can
> > intersect at some point but as of now, I don't see any benefit in doing=
 it. The goal
> > of this patchseries is to have a simple and generic framework so we can=
 connect IIO
> > devices (frontends) to a backend device having kind of an IIO aggregate=
 device so to
> > say. Moreover, we just want to have the ad9467 driver in the same state=
 it was before
> > to keep things simple. I'm already fixing some things but I don't want =
extend that
> > too much as the primary goal is to have the framework in. Cleanups can =
come
> > afterwards.
> >
> > That said, is fine to have this kind of discussion but I honestly think=
 you're over
> > engineering the whole thing. Maybe you're already too ahead of me :), b=
ut where we
> > stand right now, I don't see any reason for anything so complicated as =
the below.
> > Also note this should be simple and generic. As I already said, this is=
 not supposed
> > to be an ADI only thing and STM also wants to make use of this infrastr=
ucture. But
> > see below some of my comments on why I think it's too much... =20
>=20
> This is a very fair point. I do have a tendency to overthink things. :-)
>=20
> At the very least, being able to see the schematic of how it all fits
> together filled in the holes of my understanding and now everything
> you are doing in this series makes sense to me. And I totally agree
> with keeping it simpler is better.

Interesting discussion. One key thing it has highlighted for me is that
even the simpler proposal that Nuno has put forward deserves some
more documentation!  Preferably with some asci art - though maybe not as co=
mplex
as David's pretty picture.  I keep forgetting which is the backend and which
is the front end for this discussion which isn't helping me get my head
around it.

Jonathan



