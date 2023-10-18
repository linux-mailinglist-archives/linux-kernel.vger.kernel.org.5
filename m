Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA5B7CE773
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjJRTMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjJRTMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:12:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E90121;
        Wed, 18 Oct 2023 12:12:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A86C433C9;
        Wed, 18 Oct 2023 19:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697656370;
        bh=zl1w7jAtrkE9RQ/JgA2S1+UojLDOveGpw0c8fBGNVWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dQECTrJRS0qbI53etlnCEUOI+12qccfbH8JrkVdJnIyZTAFjQATkxgA2Ap2V19NEo
         JjDR27HQBzylU1TWe0nThpmfMmgiZw3CSaCrvRHqwPzfLyti5/q98LuHW3CgdIEo+L
         PDsVHScdgANmxn24ir2hEDWhb1C2o6m9oeio/CZDYYxJJqKA4m6CHoO1QtVn0c3gmE
         zCqtctHKvRU4xulNqXEXD4RZZFX0rod7YESN0sDcFoh5OIcz3zdb+2+CTIZa9NASBK
         hacH0E8c7LSf93GRkl0vuRbPypt18sPHwQu4KToP5kkQUsSxV6ab5tIN+0k5F6q1og
         1A59rbWhQU1EA==
Date:   Wed, 18 Oct 2023 20:13:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, u.kleine-koenig@pengutronix.de,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: imu: Add driver for BMI323 IMU
Message-ID: <20231018201309.2cf36489@jic23-huawei>
In-Reply-To: <CAM+2EuJnrJn5QLm+yqJ_4_3NiZDXS6p9P5AhwZBjFUYm+2PMGQ@mail.gmail.com>
References: <20231013034808.8948-1-jagathjog1996@gmail.com>
        <20231013034808.8948-3-jagathjog1996@gmail.com>
        <20231014174626.3c203096@jic23-huawei>
        <CAM+2EuJnrJn5QLm+yqJ_4_3NiZDXS6p9P5AhwZBjFUYm+2PMGQ@mail.gmail.com>
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

On Sun, 15 Oct 2023 16:00:34 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> On Sat, Oct 14, 2023 at 10:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Fri, 13 Oct 2023 09:18:08 +0530
> > Jagath Jog J <jagathjog1996@gmail.com> wrote:
> > =20
> > > The Bosch BMI323 is a 6-axis low-power IMU that provide measurements =
for
> > > acceleration, angular rate, and temperature. This sensor includes
> > > motion-triggered interrupt features, such as a step counter, tap dete=
ction,
> > > and activity/inactivity interrupt capabilities.
> > >
> > > The driver supports various functionalities, including data ready, FI=
FO
> > > data handling, and events such as tap detection, step counting, and
> > > activity interrupts.
> > >
> > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com> =20
> > Hi Jagath,
> >
> > Nice driver.
> >
> > We are rapidly approaching the end of this cycle and as this is a
> > large driver, I think it could do to remain on list at least a week
> > before I apply it or until it picks up some tags from others if that
> > happens sooner. Hence I'm afraid it might well sneak into next cycle. =
=20
>=20
> Hi Jonathan
>=20
> Thank you for reviewing, I understand the need for additional time
> to ensure a thorough review and to await feedback and tags from
> other reviewers. I'm okay with your schedule.
>=20
> > > +
> > > +What:                /sys/.../events/in_accel_gesture_tap_wait_dur
> > > +KernelVersion:       6.7
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Timeout value for tap gesture confirmation. =20
> >
> > Units need to be specified.  Seconds? =20
>=20
> Yes, these are in seconds. I will add units in the next series.
>=20
>=20
> > >  source "drivers/iio/imu/bmi160/Kconfig"
> > >  source "drivers/iio/imu/bno055/Kconfig"
> > > +source "drivers/iio/imu/bmi323/Kconfig" =20
> > Same on ordering. =20
>=20
> Sure I will correct this in v3.

Given they were so minor I've fixed them up whilst applying.
I doubt this will make 6.7, but you never know if things happen to align.
If not it can have a bit more build test exposure which will do no harm.

Applied to the togreg branch of iio.git and pushed out initially as
testing for all the normal reasons.

Thanks,

Jonathan

>=20
> Regards
> Jagath

