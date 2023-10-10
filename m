Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D7E7BFF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjJJOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjJJOmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:42:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB75799;
        Tue, 10 Oct 2023 07:42:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15081C433C7;
        Tue, 10 Oct 2023 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696948925;
        bh=lA6xTbD3hqaJF/U2LchiEukFCVhTNuxUo3PNv1B9SZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W/VuGz2br/m8AZim6i/6aXKvQih3Oybv4QF3iB7SsJvuNClKjaYjhadS95dPPyiTM
         OohA39UBUQ+DSb2bBw9Otw5Sxbtk1aJiVNF05jXUNrPOJXrE8Jn+cApS9MBtalLfie
         sQSmBF2aUhX6YisMhE86OIsvYs9j5CzVm9e1XeqA3p8yQfiMLl8uDj6X0Tmne2wS7+
         ZIj9YFMrHaKb8R0iVxek5xeL6qRQVJgMP5XhPIw5j9oMnPFxVaycKZKhQ9d2zQ5IKk
         3aXz6MjEV1bTZFqBLZ117Ve0wtksjOCkrf3+zXrgQTmvPmI0zoBwqNBhv90xU9YKLR
         tLI3riLR/jpvw==
Date:   Tue, 10 Oct 2023 15:42:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jagath Jog J <jagathjog1996@gmail.com>,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] dt-bindings: iio: imu: Add DT binding doc for BMI323
Message-ID: <20231010154216.6032a1c2@jic23-huawei>
In-Reply-To: <CACRpkdY+K90mN1Q1tf38FLRgEsz3q8dK9SJYSQVwGe=PL3FaUQ@mail.gmail.com>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
        <20230918080314.11959-2-jagathjog1996@gmail.com>
        <20230924143710.7c6edc4a@jic23-huawei>
        <CAM+2EuJ8o5X2ucph8gic2=03bbLQmUCX=j3SFLrqD4Y6rwXs9A@mail.gmail.com>
        <20230930170530.0b8f185c@jic23-huawei>
        <CAM+2EuKzBVbTF2SrpYEYfzap1wrONboFV-QuTU9Fz7sVjqJLeA@mail.gmail.com>
        <20231010100002.0163d681@jic23-huawei>
        <CACRpkdY+K90mN1Q1tf38FLRgEsz3q8dK9SJYSQVwGe=PL3FaUQ@mail.gmail.com>
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

On Tue, 10 Oct 2023 11:06:18 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Oct 10, 2023 at 10:59=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> > Jagath Jog J <jagathjog1996@gmail.com> wrote: =20
>=20
> > > Regarding your earlier suggestion to have two different controls for
> > > drive-open-drain, do I need to define sensor-specific drive controls
> > > in bindings for both interrupt pins?
> > > for ex: bosch,irq{1,2}-open-drain =20
> >
> > Hmm. We do have precedence for a single control e.g.
> > nxp,fxls8962af.yaml as drive-open-drain.  So perhaps just go with that
> > and if anyone is needs different values we can figure it out later.
> > pin control (which is where that binding item comes from) seems to have
> > examples doing much the same.  Sets of pins with a single drive-open-dr=
ain
> > entry.
> >
> > Linus, any comments on this as you've dealt with far more similar cases
> > than me! =20
>=20
> Also st,st-sensors use drive-open-drain.
>=20
> And that in turn is used because the pin control subsystem use that
> exact property. (See
> Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml)
>=20
> So use that.
>=20
> (I'm so happy to be able to provide a definitive answer for once!)

We kind of lost the question along the way.  Wasn't so much about whether
there was a generic binding but more about whether it is worth providing
separate controls for the two IRQ pins?  Or just assume no one is crazy
enough to play that level of mix and match.

J
>=20
> Yours,
> Linus Walleij

