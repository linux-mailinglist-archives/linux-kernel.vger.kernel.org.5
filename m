Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDDB7B230A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjI1Q4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjI1Q4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:56:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBC198;
        Thu, 28 Sep 2023 09:56:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81388C433C7;
        Thu, 28 Sep 2023 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695920190;
        bh=Hk8KloqEKCJEdSGERVaqMKSBh3+NpUUY9qA3uZFFdUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nB9cSnq6gVAz8fUbMHSZIKFljMkLidO6yeuTh/37QsEPN2EXoeNUZV/JlnliK7Mzo
         P1LS+eaeIdS7iYRJRNnVX6cxLSTHSMzD8X8B0oeHfuGZ+/qK/M/LpqmEjn54lz5Wd0
         mdNEu3hpbxlTkQeIKJCfR+40XVIU7r0WiCYm5kCBWYY30vsx7T/HXS4h7g+bglpuuC
         2XqGl80tR4osDPAvTHP4Yxbx2V0x7HuLEC1DTle7IRrasv1MAfgQmpdYZvmRNrTbtB
         VE8BPgHw3/kx29RR7RNbR5elrAsWb54gaufyv8tvagM9/3GIGvDLqMaaL+QZLOAA4/
         YiYpLp3ZsWXEw==
Date:   Thu, 28 Sep 2023 17:56:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     yang tylor <tylor_yang@himax.corp-partner.google.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org,
        "jingyliang@chromium.org" <jingyliang@chromium.org>,
        wuxy23@lenovo.com, luolm1@lenovo.com,
        hung poyu <poyu_hung@himax.corp-partner.google.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI
 device
Message-ID: <20230928-spectacle-civic-339c0d71d8d7@spud>
References: <20230922-unclothed-bottom-5531329f9724@spud>
 <CAGD2q_YsFdDVhE4JCmQSGMWOdpe_yzG8-CdWYPXtjeZsManvgQ@mail.gmail.com>
 <20230922-removable-footwork-f1d4d96d38dd@spud>
 <CAGD2q_Y467jJJnwCVH+3F-hh6a-1-OYRugcy0DdjPnTCC77Z8A@mail.gmail.com>
 <20230925-cod-vacancy-08dc8d88f90e@wendy>
 <CAGD2q_a1nLtFj7H42f+u+J5Bih59MGS0aJLHCFJy5gM2ydys4w@mail.gmail.com>
 <20230926-action-sludge-ec8e51fdd6d4@spud>
 <CAGD2q_YBfDT950tyxEF87ZeiANgea_x8S16Ud5K2bcQ+eL9T=w@mail.gmail.com>
 <20230926-reverence-unlit-d0027225cc43@spud>
 <CAGD2q_ZzNPOL+Mhg7aWFTQd+UJJYVLz1ZE9hbNb0roS2M6y34g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bSuXjL7jXH8FBE98"
Content-Disposition: inline
In-Reply-To: <CAGD2q_ZzNPOL+Mhg7aWFTQd+UJJYVLz1ZE9hbNb0roS2M6y34g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bSuXjL7jXH8FBE98
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 10:12:41AM +0800, yang tylor wrote:
> On Tue, Sep 26, 2023 at 8:53=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Tue, Sep 26, 2023 at 05:52:39PM +0800, yang tylor wrote:
> > > On Tue, Sep 26, 2023 at 5:02=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > > > On Mon, Sep 25, 2023 at 06:16:29PM +0800, yang tylor wrote:
> > > > > On Mon, Sep 25, 2023 at 4:41=E2=80=AFPM Conor Dooley <conor.doole=
y@microchip.com> wrote:
> > > > > > On Mon, Sep 25, 2023 at 09:44:21AM +0800, yang tylor wrote:
> > > > > > > On Fri, Sep 22, 2023 at 11:31=E2=80=AFPM Conor Dooley <conor@=
kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Sep 22, 2023 at 05:43:54PM +0800, yang tylor wrote:
> > > > > > > > > On Fri, Sep 22, 2023 at 5:22=E2=80=AFPM Conor Dooley <con=
or@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Sep 22, 2023 at 03:56:25PM +0800, yang tylor wr=
ote:
> > > > > > > > > > > On Tue, Sep 19, 2023 at 7:09=E2=80=AFPM Conor Dooley =
<conor@kernel.org> wrote:
> > > > > > > > > > > > On Tue, Sep 19, 2023 at 05:31:29PM +0800, yang tylo=
r wrote:
> > > > > > > > > >
> > > > > > > > > > > > > The behavior of "himax,boot_time_fw_upgrade" seem=
s not stable and
> > > > > > > > > > > > > should be removed. "himax,fw_in_flash", I use the=
 kernel config for
> > > > > > > > > > > > > user to select.
> > > > > > > > > > > >
> > > > > > > > > > > > That seems like a bad idea, we want to be able to b=
uild one kernel that
> > > > > > > > > > > > works for all hardware at the same time.
> > > > > > > > > > > >
> > > > > > > > > > > I see, so I should take that back?
> > > > > > > > > > > I'll explain more about it.
> > > > > > > > > >
> > > > > > > > > > Are there particular ICs where the firmware would alway=
s be in flash and
> > > > > > > > > > others where it would never be? Or is this a choice mad=
e by the board or
> > > > > > > > > > system designer?
> > > > > > > > > >
> > > > > > > > > Most cases it's about the system designer's decision. But=
 some ICs may be forced
> > > > > > > > > to use flash because of its architecture(multiple IC insi=
de, need to
> > > > > > > > > load firmware to
> > > > > > > > > multiple IC's sram by master IC). But if there is no limi=
tation on
> > > > > > > > > this part, most system
> > > > > > > > > designers will prefer flashless.
> > > > > > > >
> > > > > > > > Forgive me if I am not understanding correctly, there are s=
ome ICs that
> > > > > > > > will need to load the firmware from flash and there are som=
e where it
> > > > > > > > will be a decision made by the designer of the board. Is th=
e flash part
> > > > > > > > of the IC or is it an external flash chip?
> > > > > > > >
> > > > > > >
> > > > > > > Both are possible, it depends on the IC type. For TDDI, the I=
C is long
> > > > > > > and thin, placed on panel PCB, flash will be located at the e=
xternal
> > > > > > > flash chip. For the OLED TP, IC is usually placed at FPC and =
its flash
> > > > > > > is embedded, thus the IC size is large compared to TDDI. But =
=66rom the
> > > > > > > driver's perspective either external flash or embedded flash,=
 the IC
> > > > > > > itself will load firmware from flash automatically when reset=
 pin is
> > > > > > > released. Only if firmware is loading from the host storage s=
ystem,
> > > > > > > the driver needs to operate the IC in detail.
> > > > > >
> > > > > >
> > > > > > Since there are ICs that can use the external flash or have it =
loaded
> > > > > > from the host, it sounds like you do need a property to differe=
ntiate
> > > > > > between those cases.
> > > > > Yep.
> > > > >
> > > > > > Is it sufficient to just set the firmware-name property for the=
se cases?
> > > > > > If the property exists, then you know you need to load firmware=
 & what
> > > > > > its name is. If it doesn't, then the firmware either isn't need=
ed or
> > > > > > will be automatically loaded from the external flash.
> > > >
> > > > > We have a default prefix firmware name(like himax_xxxx.bin) in th=
e driver code.
> > > >
> > > > How do you intend generating the name of the firmware file? I assum=
e the
> > > > same firmware doesn't work on every IC, so you'll need to pick a
> > > > different one depending on the compatible?
> > > >
> > > If considering a firmware library line-up for all the incoming panels
> > > of this driver.
> > > We would use PID as part of the file name. Because all the support pa=
nels would
> > > have a unique PID associated. Which will make the firmware name like
> > > himax_xxx_{$PID}.bin. The problem is, we need to know PID before firm=
ware load
> > > at no flash condition. Thus PID information is required in dts when
> > > no-flash-flag
> > > is specified.
> >
> > Firstly, where does the "xxx" come from?
> > And you're making it sound more like having firmware-name is suitable
> > for this use case, given you need to determine the name of the file to
> > use based on something that is hardware specific but is not
> > dynamically detectable.
> Current driver patch uses a prefix name "himax_i2chid" which comes
> from the previous project
>  and seems not suitable for this condition, so I use "xxx" and plan to
> replace it in the next version.
> For finding firmware, I think both solutions are reasonable.
> - provide firmware name directly: implies no-flash and use user
> specified firmware, no PID info.
> - provide no-flash-flag and PID info: loading firmware from organized
> names with PID info.
> I prefer the 2nd solution, but it needs more properties in dts. 1st
> has less properties and more
> intuitive.
>=20
> I don't know which one is more acceptable by the community, as you
> know I'm a newbie here.

To be honest, I am not all that sure either! Does the panel id have
value in its own right, or is that only used to determine the firmware
filename?
Also, if it does have value in its own right, rather than a "pid",
should the panel be a child node of this hid device with its own
compatible?

--bSuXjL7jXH8FBE98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRWwOQAKCRB4tDGHoIJi
0lskAQDqeySBuuy9UeRNTd2J7pBoiNgkhCeuu09nRsMmLhTj2gD/buaLFC4NFIN7
ky3Vz2QA/3plpu9BSW4iCFkeDD5tLwk=
=KMnv
-----END PGP SIGNATURE-----

--bSuXjL7jXH8FBE98--
