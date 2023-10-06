Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E117BB9FA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjJFOLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjJFOLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:11:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B095AD;
        Fri,  6 Oct 2023 07:11:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30ABC433C9;
        Fri,  6 Oct 2023 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696601489;
        bh=5tWpzn+db/xeesoge1NIJxaqKZEBJNCGXxgh72xvPnI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sclvbRf3j5/VQUNwhfrnngjkICudKIMNiN3Uxkp73tEzBBWUdOME4Zh6s6EIYphwZ
         METNwvLIiegNONyMNktrsxV6RhogXZUtyeYWtfXWLS51VrZP+SWFkLRZnweqBwl8Eh
         bbNRvfqF/rayqXEmSrS1oRiTTjc2uZixT8WPIQVG+ftWG5mCxS5AeHwRpUd54BYk5m
         jNaRhe3Fw40VnNviTTUmQStmgsbL1QMbw5ydPGnUB8zZBAxFWc2kHfPGHX8ERoayS8
         MpQFUBLd/cBge+yypJwXEIzuAEA1X875e2O/atxCKdA4UxyU/o4TDzyf5lcWniMioR
         LKkcuMOIFPo+A==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bff936e10fso39334101fa.1;
        Fri, 06 Oct 2023 07:11:29 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx5ywyNVv5tdaXeHY1vGCybieFEAwjXLCIFKYnG671hHlujnaPi
        M2g1KElWp4z3z81J4E33/bnQ/2KS1WXveB/8ow==
X-Google-Smtp-Source: AGHT+IGnz1Ff6DvENmltYUWEskgQXY/YyUpIq7T1Rw7LI+ePtRgtX8IVkWZIARzzAawJA3leguoktI0tJw9wWIAMTg8=
X-Received: by 2002:a05:6512:1245:b0:504:20a5:7375 with SMTP id
 fb5-20020a056512124500b0050420a57375mr4003520lfb.29.1696601487910; Fri, 06
 Oct 2023 07:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230928151631.149333-1-jcmvbkbc@gmail.com> <20230928151631.149333-6-jcmvbkbc@gmail.com>
 <2023100326-crushing-septic-4856@gregkh> <CAMo8BfJgpP-=tNEChcyR3z6i_QeJ9Ywq7EOjjC5i7Uq4OrgXNA@mail.gmail.com>
In-Reply-To: <CAMo8BfJgpP-=tNEChcyR3z6i_QeJ9Ywq7EOjjC5i7Uq4OrgXNA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 6 Oct 2023 09:11:15 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+P9VAv1uSn=sU1J7Q-=mgFBFiOj7EkgncnrQwhWGQETA@mail.gmail.com>
Message-ID: <CAL_Jsq+P9VAv1uSn=sU1J7Q-=mgFBFiOj7EkgncnrQwhWGQETA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] drivers/tty/serial: add ESP32S3 ACM device driver
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Oct 3, 2023 at 2:47=E2=80=AFPM Max Filippov <jcmvbkbc@gmail.com> wr=
ote:
>
> On Tue, Oct 3, 2023 at 5:55=E2=80=AFAM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Sep 28, 2023 at 08:16:31AM -0700, Max Filippov wrote:
> > > Add driver for the ACM  controller of the Espressif ESP32S3 Soc.
> >
> > Odd extra space :(
>
> Ok.
>
> > > Hardware specification is available at the following URL:
> > >
> > >   https://www.espressif.com/sites/default/files/documentation/esp32-s=
3_technical_reference_manual_en.pdf
> > >   (Chapter 33 USB Serial/JTAG Controller)
> >
> > I don't understand this driver, "ACM" is a USB host <-> gadget protocol=
,
> > why do you need a platform serial driver for this?
>
> The USB part of this piece of hardware is fixed and not controllable, so
> all we have is a very limited UART interface. But to the outside world
> it's a USB device with the CDC-ACM interface.
>
> > > diff --git a/drivers/tty/serial/esp32_acm.c b/drivers/tty/serial/esp3=
2_acm.c
> > > new file mode 100644
> > > index 000000000000..f02abd2ac65e
> > > --- /dev/null
> > > +++ b/drivers/tty/serial/esp32_acm.c
> > > @@ -0,0 +1,459 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> >
> > Why "or later"?  I have to ask, sorry.
>
> I don't really have a preference here. Is there a reason to choose
> GPL-2.0 only for a new code?

Yes, that's the default license for the kernel. So you should have a
reason for picking something else. Like maybe you copied all this from
somewhere else and that was the license.

Rob
