Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9822F799E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbjIJNug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjIJNug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 09:50:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D296ACC5;
        Sun, 10 Sep 2023 06:50:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C72C433C7;
        Sun, 10 Sep 2023 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694353831;
        bh=a/EEGpvo/bK+O5iYQ0fsAhegdogdjwxLNJQ7K4ATQyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YaTyWbya49IiNmT+Kft7EpgmY5XSOqh8DXLB5twblCxRZ9/2XN/Jet3px8QP14BTO
         ntGsU75my7iJ9yTwzsA5n5XZAMy9gyDfIqBHKTUnAFow+k2jpO1cJ2+1om9A9tPfJ0
         39gxA4NDyrNLXP09wlK9rHvCI5OkDR17X52TPQk7CucUCSXxSTTIBp7U7g+w+MA4Gl
         aSDWFSfOTBlo+WIzDBS0/2J1ZhdLsoxbdPGAXUKHWwWeEe0k0llc+I96Plk324jkPM
         Mb7fQukNf6pgFWB1jiIieLvybcflMeTZvp5+PSbkl6tep+Yv4xlaAe7OuoJUuiRg76
         uOTgBK+9pV7GA==
Date:   Sun, 10 Sep 2023 14:50:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] iio: pressure: dps310: Adjust Timeout Settings
Message-ID: <20230910145025.34cc4728@jic23-huawei>
In-Reply-To: <D273D407-B2EE-4089-95C9-43CF937B91EB@us.ibm.com>
References: <20230829180222.3431926-1-lakshmiy@us.ibm.com>
        <20230829180222.3431926-2-lakshmiy@us.ibm.com>
        <20230903125309.12c59189@jic23-huawei>
        <D273D407-B2EE-4089-95C9-43CF937B91EB@us.ibm.com>
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

On Wed, 6 Sep 2023 14:55:25 +0000
Lakshmi Yadlapati <lakshmiy@us.ibm.com> wrote:

> Fixes: 7b4ab4abcea4 ("iio: pressure: dps310: Reset chip after timeout")
>=20
> Thanks,
> Lakshmi
>=20
Applied to the fixes-togreg branch of iio.git
Note I'll probably rebase on rc1 before sending a pull request.

Thanks,

Jonathan

> =EF=BB=BFOn 9/3/23, 6:52 AM, "Jonathan Cameron" <jic23@kernel.org <mailto=
:jic23@kernel.org>> wrote:
>=20
>=20
> On Tue, 29 Aug 2023 13:02:22 -0500
> Lakshmi Yadlapati <lakshmiy@us.ibm.com <mailto:lakshmiy@us.ibm.com>> wrot=
e:
>=20
>=20
> > The DPS310 sensor chip has been encountering intermittent errors while
> > reading the sensor device across various system designs. This issue cau=
ses
> > the chip to become "stuck," preventing the indication of "ready" status
> > for pressure and temperature measurements in the MEAS_CFG register.
> >=20
> > To address this issue, this commit fixes the timeout settings to improve
> > sensor stability:
> > - After sending a reset command to the chip, the timeout has been exten=
ded
> > from 2.5 ms to 15 ms, aligning with the DPS310 specification.
> > - The read timeout value of the MEAS_CFG register has been adjusted from
> > 20ms to 30ms to match the specification.
> >=20
> > Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com <mailto:lakshmiy@=
us.ibm.com>> =20
> Hi Lakshmi,
>=20
>=20
> This seems reasonable to me, but as we probably want to backport it to
> stable kernels, please could you figure out an appropriate Fixes tag.
>=20
>=20
> Fine to just reply to this email with the tag rather than resend.
>=20
>=20
> Thanks
>=20
>=20
> Jonathan
>=20
>=20
> > ---
> > drivers/iio/pressure/dps310.c | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps31=
0.c
> > index b10dbf5cf494..1ff091b2f764 100644
> > --- a/drivers/iio/pressure/dps310.c
> > +++ b/drivers/iio/pressure/dps310.c
> > @@ -57,8 +57,8 @@
> > #define DPS310_RESET_MAGIC 0x09
> > #define DPS310_COEF_BASE 0x10
> >=20
> > -/* Make sure sleep time is <=3D 20ms for usleep_range */
> > -#define DPS310_POLL_SLEEP_US(t) min(20000, (t) / 8)
> > +/* Make sure sleep time is <=3D 30ms for usleep_range */
> > +#define DPS310_POLL_SLEEP_US(t) min(30000, (t) / 8)
> > /* Silently handle error in rate value here */
> > #define DPS310_POLL_TIMEOUT_US(rc) ((rc) <=3D 0 ? 1000000 : 1000000 / (=
rc))
> >=20
> > @@ -402,8 +402,8 @@ static int dps310_reset_wait(struct dps310_data *da=
ta)
> > if (rc)
> > return rc;
> >=20
> > - /* Wait for device chip access: 2.5ms in specification */
> > - usleep_range(2500, 12000);
> > + /* Wait for device chip access: 15ms in specification */
> > + usleep_range(15000, 55000);
> > return 0;
> > }
> >  =20
>=20
>=20
>=20
>=20
>=20

